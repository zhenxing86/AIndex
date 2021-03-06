USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：修改日记文章
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_Update]
@postid int,
@title nvarchar(30),
@content ntext,
@poststatus int,
@categoriesid int,
@commentstatus int,
@IsTop bit,
@IsSoul bit,
@smile nvarchar(30),
@viewpermission int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @oldcategoriesid int
	SELECT @oldcategoriesid=categoriesid FROM blog_posts where postid=@postid
	
	IF(@oldcategoriesid<>@categoriesid)
	BEGIN
		UPDATE blog_postscategories SET postcount=postcount+1 	WHERE categoresid=@categoriesid
		UPDATE blog_postscategories SET postcount=postcount-1 	WHERE categoresid=@oldcategoriesid
	END
	
	UPDATE blog_posts SET 
	[title] = @title,[content] = @content,[poststatus] = @poststatus,[categoriesid] = @categoriesid,
	[commentstatus] = @commentstatus,[IsTop] = @IsTop,[IsSoul] = @IsSoul,
	[smile] = @smile,[viewpermission]=@viewpermission
	WHERE postid=@postid 
		
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
