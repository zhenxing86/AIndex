USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：增加幼儿园共享分类
--项目名称：BLOG
--说明：
--时间：2009-6-27 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[kin_doc_category_ADD]
@parentid int,
@title nvarchar(50),
@description nvarchar(100),
@kid int

 AS 

	INSERT INTO [kin_doc_category](
	[parentid],[title],[description],[kid],[documentcount],[createdatetime]
	)VALUES(
	@parentid,@title,@description,@kid,0,getdate()
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
