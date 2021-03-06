USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_AproveUpdate]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：修改公共文档审核状态 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-21 10:38:17
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_AproveUpdate]
@docid int
 AS 	
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @aprove int	
	DECLARE @pubcategoryid int
	DECLARE @parentpubcategoryid int

	SELECT @aprove=aprove,@pubcategoryid=pubcategoryid FROM thelp_documents WHERE docid=@docid 

	IF(@aprove<>0) 
	BEGIN
			UPDATE thelp_documents SET 
			[aprove] = 0
			WHERE docid=@docid 

			UPDATE pub_doc_category SET documentcount=documentcount-1 WHERE pubcategoryid=@pubcategoryid 
			SELECT @parentpubcategoryid=parentid FROM pub_doc_category where pubcategoryid=@pubcategoryid 
			IF(@parentpubcategoryid<>0)
			BEGIN
				UPDATE pub_doc_category SET documentcount=documentcount-1 WHERE pubcategoryid=@parentpubcategoryid 
			END

	END
	ELSE
	BEGIN
			UPDATE thelp_documents SET 
			[aprove] = 1
			WHERE docid=@docid 

			UPDATE pub_doc_category SET documentcount=documentcount+1 WHERE pubcategoryid=@pubcategoryid 
			SELECT @parentpubcategoryid=parentid FROM pub_doc_category where pubcategoryid=@pubcategoryid 
			IF(@parentpubcategoryid<>0)
			BEGIN
				UPDATE pub_doc_category SET documentcount=documentcount+1 WHERE pubcategoryid=@parentpubcategoryid 
			END

	END

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN 1
	END












GO
