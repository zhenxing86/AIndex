USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_categories_Update]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改文档分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 22:36:39
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_categories_Update]
@categoryid int,
@title nvarchar(50),
@description nvarchar(100),
@parentid int,
@displayorder int
 AS
UPDATE thelp_categories SET 
	[title] = @title,[description] = @description,[parentid]=@parentid,displayorder=@displayorder
	WHERE categoryid=@categoryid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END



GO
