USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	添加明星幼儿
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidapapoose_Add]
@siteid int,
@userid int
AS
BEGIN
	IF EXISTS(SELECT * FROM blog_lucidapapoose WHERE siteid=@siteid AND userid=@userid)
	BEGIN
		RETURN 2
	END
	ELSE
	BEGIN

	declare @name nvarchar(50)
    declare @headpic nvarchar(150)
    declare @visitscount int
	declare @headpicupdatetime datetime
	select @name =t1.nickname,@headpicupdatetime=t1.headpicupdate, @headpic=t1.headpic 
	from basicdata..user_bloguser  t2 
	inner join basicdata..[user] t1 on t2.userid=t1.userid  
	where t2.bloguserid=@userid

	select @visitscount=visitscount from blogapp..blog_baseconfig where userid=@userid
		INSERT INTO blog_lucidapapoose(siteid,userid,name,headpicupdate,headpic,visitscount) 
		VALUES(@siteid,@userid,@name,@headpicupdatetime,@headpic,@visitscount)
		--exec [kweb_site_RefreshIndexPage] @siteid
		IF @@ERROR <> 0
		BEGIN
			RETURN 0
		END
		ELSE
		BEGIN
			RETURN 1
		END
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_lucidapapoose_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
