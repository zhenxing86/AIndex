USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[subcontent_relation_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-11
-- Description:	ADD
-- =============================================
CREATE PROCEDURE [dbo].[subcontent_relation_Add]
@contentid int,
@subcategoryid int
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @categoryid int
	SELECT @categoryid=categoryid FROM cms_subcategory WHERE subcategoryid=@subcategoryid

	EXEC [content_content_relation_Add] @contentid,@categoryid

	IF EXISTS(SELECT * FROM mh_subcontent_relation WHERE contentid=@contentid)
	BEGIN
		UPDATE mh_subcontent_relation SET subcategoryid=@subcategoryid WHERE contentid=@contentid
	END
	ELSE
	BEGIN
		INSERT INTO mh_subcontent_relation(subcategoryid,contentid,createdatetime)
		VALUES(@subcategoryid,@contentid,GETDATE())	
	END
	
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END



GO
