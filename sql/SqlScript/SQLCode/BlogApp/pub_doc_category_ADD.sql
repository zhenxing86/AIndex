USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[pub_doc_category_ADD]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加共享分类
--项目名称：BLOG
--说明：
--时间：2009-7-1 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[pub_doc_category_ADD]
@parentid int,
@title nvarchar(50),
@description nvarchar(100)

 AS 

	INSERT INTO [pub_doc_category](
	[parentid],[title],[description],[documentcount],[createdatetime]
	)VALUES(
	@parentid,@title,@description,0,getdate()
	)
	

	IF @@ERROR<>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END





GO
