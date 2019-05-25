USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscategories_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改日记分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-30 22:57:13
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscategories_Update]
@categoresid int,
@title nvarchar(30),
@description nvarchar(100)
 AS 
	UPDATE blog_postscategories SET 
	[title] = @title,[description] = @description
	WHERE categoresid=@categoresid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END






GO
