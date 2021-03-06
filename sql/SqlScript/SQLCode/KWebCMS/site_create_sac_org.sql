USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_create_sac_org]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	为站点创建权限组织
-- =============================================
CREATE PROCEDURE [dbo].[site_create_sac_org]
@siteid int
AS
BEGIN TRANSACTION
DECLARE @site_org_id int
SELECT @site_org_id=org_id FROM site WHERE siteid=@siteid
IF(@site_org_id is null or @site_org_id=0)
BEGIN
DECLARE @name nvarchar(50)
DECLARE @regdatetime DATETIME
DECLARE @org_id int
DECLARE @site_instance_id int
SELECT @name=name,@regdatetime=regdatetime FROM site WHERE siteid=@siteid
INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id) VALUES(@name,@regdatetime,0)
SELECT @org_id=@@IDENTITY
UPDATE site SET org_id=@org_id WHERE siteid=@siteid
INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)
VALUES (@org_id,1,@name+'网站后台',1)
SELECT @site_instance_id=@@IDENTITY
DECLARE @manage_role_id int
INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')
SELECT @manage_role_id=@@IDENTITY
DECLARE @principal_role_id int
INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')
SELECT @principal_role_id=@@IDENTITY
DECLARE @teacher_role_id int
INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
SELECT @teacher_role_id=@@IDENTITY
INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)VALUES(@manage_role_id,1)
INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)VALUES(@principal_role_id,1)

DECLARE @userid int
DECLARE cursor_user CURSOR FOR
SELECT userid FROM site_user where siteid=@siteid and usertype=98
OPEN cursor_user
FETCH next FROM cursor_user INTO @userid
WHILE(@@fetch_status=0)
BEGIN
	DECLARE @usertype int
	DECLARE @right_userid int
	declare @account nvarchar(30)
	declare @password nvarchar(64)
	declare @username nvarchar(30)
	declare @createdatetime datetime
	SELECT @account=account,@password=password,@username=name,@createdatetime=createdatetime,@usertype=usertype FROM site_user WHERE userid=@userid				
	INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)
	VALUES(@account,@password,@username,@createdatetime,@org_id,1)
	SELECT @right_userid=@@IDENTITY
	UPDATE site_user SET UID=@right_userid WHERE userid=@userid
	IF(@usertype=98 OR @usertype=1)
	BEGIN
		insert into KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)
	END
	ELSE IF(@usertype=97)
	BEGIN
		insert into KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@principal_role_id)
	END
	FETCH next FROM cursor_user INTO @userid
END
CLOSE cursor_user
DEALLOCATE cursor_user
END


IF @@ERROR <> 0 
BEGIN	
	ROLLBACK TRANSACTION
   RETURN(-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
   RETURN (1)
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_create_sac_org', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
