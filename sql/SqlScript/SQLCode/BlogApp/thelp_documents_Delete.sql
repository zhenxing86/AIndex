USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_Delete]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：删除文档
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_Delete]
@docid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE	@categoryid int
	DECLARE @kindisplay int
	DECLARE @kindoccategoryid int
	DECLARE @pubcategoryid int
	DECLARE @publishdisplay int
	DECLARE @aprove INT

	SELECT @categoryid=categoryid,@kindisplay=kindisplay,@kindoccategoryid=kindoccategoryid,@pubcategoryid=pubcategoryid,@publishdisplay=publishdisplay,@aprove=aprove FROM thelp_documents WHERE docid=@docid

	IF(@kindisplay=1)
	BEGIN
		UPDATE kin_doc_category SET documentcount=documentcount-1 WHERE kincategoryid=@kindoccategoryid
	END

	IF(@publishdisplay=1 and @aprove=1)
	BEGIN
		UPDATE pub_doc_category SET documentcount=documentcount-1 WHERE pubcategoryid=@pubcategoryid
	END
	
	--更新文档分类文档数量	
	UPDATE thelp_categories SET documentcount=documentcount-1 WHERE categoryid=@categoryid

	--删除文档附件
	DELETE thelp_docattachs WHERE docid=@docid

	--删除文档评论
	DELETE thelp_doccomment WHERE docid=@docid
	
	--删除文档记录
	--DELETE thelp_documents WHERE docid=@docid 
	update thelp_documents set deletetag=0 where docid=@docid

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
