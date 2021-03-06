USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_orderno_desc]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-31
-- Description:	DESC
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_orderno_desc]
@id int
AS
BEGIN	
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	SELECT @currentOrderNo=orderno FROM resourceapp..course_content WHERE id=@id

	DECLARE @NewOrderNo int
	DECLARE @NewID int
	SELECT TOP 1 @NewID=id,@NewOrderNo=orderno FROM resourceapp..course_content WHERE orderno<@currentOrderNo ORDER BY orderno DESC

	IF @NewID IS NULL OR @NewOrderNo IS NULL
	BEGIN
		COMMIT TRANSACTION
		RETURN 2
	END

	update resourceapp..course_content set orderno=@NewOrderNo where id=@id

	update resourceapp..course_content set orderno=@currentOrderNo where id=@NewID

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
END







GO
