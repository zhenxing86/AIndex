USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_Update]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改班级文章
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_article_Update]
@articleid int,
@title nvarchar(100),
@classid int,
@content ntext,
@publishdisplay int,
@istop int 

 AS 
	UPDATE [class_article] SET 
	[title] = @title,[classid] = @classid,[content] = @content,[publishdisplay] = @publishdisplay,[istop]=@istop,[createdatetime] = getdate()
	WHERE articleid=@articleid 

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END




GO
