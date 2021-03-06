USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentpaging_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-02
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentpaging_Delete]
@pagingid int
AS
BEGIN

	BEGIN TRANSACTION

	DECLARE @contentid int
	DECLARE @num int

	SELECT @contentid=contentid FROM cms_contentpaging WHERE pagingid=@pagingid

	DELETE cms_contentpaging WHERE pagingid=@pagingid

	SELECT @num=count(*) FROM cms_contentpaging WHERE contentid=@contentid

	IF @num = 0
	BEGIN
		UPDATE cms_content SET ispageing=0 WHERE contentid=@contentid
	END	
	
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN(1)
	END
END





GO
