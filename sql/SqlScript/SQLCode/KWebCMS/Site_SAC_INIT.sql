USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Site_SAC_INIT]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ALONG
-- Create date: 2012-11-15
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Site_SAC_INIT]
@org_id INT,
@name nvarchar(50),
@account nvarchar(30),
@password nvarchar(32),
@currentSiteID INT,
@userid INT,
@isxxt INT,
@siteid INT
AS

		DECLARE @currentUserID int	--siteuserid
		DECLARE @site_instance_id INT
		INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)VALUES (@org_id,1,@name+'网站后台',0)
		SELECT @site_instance_id=@@IDENTITY
		DECLARE @manage_role_id INT
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')
		SELECT @manage_role_id=@@IDENTITY
		DECLARE @principal_role_id INT
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')
		SELECT @principal_role_id=@@IDENTITY
		DECLARE @teacher_role_id INT
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
		SELECT @teacher_role_id=@@IDENTITY

		DECLARE @right_userid INT
		INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)
		VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)
		SELECT @right_userid=@@IDENTITY
		INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) VALUES(@right_userid,@manage_role_id)

		INSERT INTO site_user(siteid,account,password,[name],createdatetime,usertype,UID,appuserid) VALUES(@currentSiteID,@account,@password,'网站管理员',GETDATE(),98,@right_userid,@userid)
		SELECT @currentUserID=@@IDENTITY


		IF (@isxxt>0)
		BEGIN
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id WHERE siteid=@siteid and  right_id<>29
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id WHERE siteid=@siteid and right_id<>29
			DECLARE @xxtid INT
			INSERT INTO KWebCMS_Right..[sac_right](
			[site_id],[site_instance_id],[up_right_id],[right_name],[right_code]
			)VALUES(
			1,@site_instance_id,1,'园讯通','YEYWZHT_YXT'
			)
			SET @xxtid = @@IDENTITY
			INSERT INTO site_menu(title,url,target,parentid,categoryid,imgpath,orderno,siteid,right_id)
			VALUES('园讯通','http://www.xxt139.com/parent/','_blank',0,0,'bt_xxt',4,@currentSiteID,@xxtid)
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) VALUES(@manage_role_id,@xxtid)
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) VALUES(@principal_role_id,@xxtid)

			INSERT INTO appconfig..tem_kidapp(opkid,appid) VALUES(@currentSiteID,29)
		END
		ELSE
		BEGIN
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id WHERE siteid=@siteid
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id WHERE siteid=@siteid
		END

if(not exists(select 1 from basicdata..department where kid=@currentSiteID))
begin
	--declare @name nvarchar(50)
	declare @did int
	declare @did2 int
	--select @name=kname from kindergarten where kid=@kid
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES(@name,0,1,1,@currentSiteID,GETDATE())
       
       SET @did=@@IDENTITY
      
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
       VALUES('行政部',@did,1,1,@currentSiteID,GETDATE())
       
       SET @did2=@@IDENTITY
       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@currentSiteID,GETDATE())
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,4,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,5,1,@currentSiteID,GETDATE())       
       INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,6,1,@currentSiteID,GETDATE())
end

if not Exists (Select * From Basicdata..class Where kid=@currentSiteID)
begin
--创建默认班级
	INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)
	SELECT @currentSiteID,name,classgrade,1,getdate(),1,0 from    basicdata..Templates_Class --where classgrade=35	
end

DELETE reg_site_temp WHERE userid=@userid


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Site_SAC_INIT', @level2type=N'PARAMETER',@level2name=N'@password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Site_SAC_INIT', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
