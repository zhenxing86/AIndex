USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostSysCategoryRelationADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条日记系统分类记录 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-21 16:01:37
------------------------------------select * from blog_postsyscategory where id=11
CREATE PROCEDURE [dbo].[Manage_BlogPostSysCategoryRelationADD]
@categoryid int,
@postid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	INSERT INTO blog_postsyscategory_relation(
	[categoryid],[postid],[status],[actiondate]
	)VALUES(
	@categoryid,@postid,1,getdate()
	)
	
	UPDATE blog_postsyscategory SET postcount=postcount+1 WHERE id=@categoryid
	
--	declare @count int
--	select @count=count(1) from blog_hotposts where [postid]=@postid
--	IF(@count=0)
--	BEGIN
--		DECLARE @author nvarchar(100)
--		DECLARE @userid int
--		DECLARE @title nvarchar(100)
--		DECLARE @mainurl nvarchar(200)
--		DECLARE @suburl nvarchar(200)

--		SELECT @userid=userid,@author=author,@title=title FROM blog_posts WHERE postid=@postid
--		SET @mainurl='http://blog.zgyey.com/'+cast(@userid AS nvarchar(20))+'/index.html'
--		SET	@suburl='http://blog.zgyey.com/'+cast(@userid  AS nvarchar(20))+'/diary/diaryview_'+cast(@postid  AS nvarchar(20))+'.html'
----		EXEC Manage_BlogHotPostsAdd @author,@title,@mainurl,@suburl,0,@postid
----		EXEC Manage_BlogHotPostsAdd @author,@title,'http://blog.zgyey.com/'+cast(@userid AS nvarchar(20))+'/index.html','http://blog.zgyey.com/'+cast(@userid  AS nvarchar(20))+'/diary/diaryview_'+cast(@postid  AS nvarchar(20))+'.html',0,@postid

--	END

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
