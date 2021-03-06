USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_Init]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加幼儿园共享目录
--项目名称：zgyeyblog 
--说明：
--时间：2009-07-1 09:54:31
------------------------------------
CREATE PROCEDURE [dbo].[kin_doc_category_Init]
@kid int
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @kindoccategoryid int
	set @kindoccategoryid=0

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'教学安排','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'工作计划','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'工作总结','',@kid,0,getdate(),1,1)


	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'观察记录','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'教学反思','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'个案分析','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'常用表格','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'家长会稿','',@kid,0,getdate(),1,1)

	INSERT INTO [docapp].[dbo].[kin_doc_category]([parentid],[title],[description],[kid],[documentcount],[createdatetime],displayorder,status)
	VALUES   (@kindoccategoryid,'评价评语','',@kid,0,getdate(),1,1)

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
