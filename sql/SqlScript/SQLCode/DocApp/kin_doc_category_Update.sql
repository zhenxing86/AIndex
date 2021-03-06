USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_Update]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改幼儿园共享分类
--项目名称：BLOG
--说明：
--时间：2009-6-27 16:22:32
------------------------------------

CREATE PROCEDURE [dbo].[kin_doc_category_Update]
@kincategoryid int,
@parentid int,
@title nvarchar(50),
@description nvarchar(100),
@displayorder int

 AS
UPDATE [kin_doc_category] SET 
	[parentid]=@parentid,[title] = @title,[description]=@description,[createdatetime]=getdate(),displayorder=@displayorder
	WHERE kincategoryid=@kincategoryid 

	IF @@ERROR<>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
