USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogHotPostsAdd]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加最热推荐
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 16:37:29
--作者：along
------------------------------------
create PROCEDURE [dbo].[Manage_BlogHotPostsAdd]
@maintitle nvarchar(100),
@subtitle nvarchar(100),
@mainurl nvarchar(200),
@suburl nvarchar(200),
@posttype int,
@postid int,
@hottype int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @orderno int
	SELECT @orderno=max(orderno)+1 FROM blog_hotposts WHERE posttype=@posttype	
	
	INSERT INTO blog_hotposts(
	[maintitle],[subtitle],[mainurl],[suburl],[orderno],[posttype],[createdate],[postid],[istop],[hottype]
	)VALUES(
	@maintitle,@subtitle,@mainurl,@suburl,@orderno,@posttype,getdate(),@postid,0,@hottype
	)
	
	UPDATE blog_posts SET [IsHot] = 1
	WHERE postid=@postid 

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @@IDENTITY
	END



GO
