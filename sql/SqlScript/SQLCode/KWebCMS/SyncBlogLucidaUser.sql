USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[SyncBlogLucidaUser]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	获取默认首页
-- =============================================
CREATE PROCEDURE [dbo].[SyncBlogLucidaUser]

AS
BEGIN
	INSERT INTO kwebcms..blog_lucidaUser_log(appuserid,bloguserid,usertype,name,siteid)
select  t1.userid,t1.bloguserid,t4.usertype,t4.[name],t4.kid 
from  basicdata..user_bloguser  t1  
inner join basicdata..[user] t4 on t1.userid=t4.userid 
where not exists(select  bloguserid from blog_lucidaUser_log where bloguserid=t1.bloguserid) and t4.deletetag=1

END

GO
