USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portal_href_OrderNo_ASC]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	orderno asc
-- =============================================
CREATE PROCEDURE [dbo].[portal_href_OrderNo_ASC]
@id int
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	DECLARE @NewOrderNo int
	DECLARE @NewID int
	SELECT @currentOrderNo=orderno FROM portal_href WHERE id=@id
	SELECT TOP 1 @NewOrderNo=orderno,@NewID=id FROM portal_href WHERE orderno>@currentOrderNo ORDER BY orderno ASC

	IF @NewOrderNo IS NULL
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
	ELSE
	BEGIN
		UPDATE portal_href SET orderno=@NewOrderNo WHERE id=@id

		UPDATE portal_href SET orderno=@currentOrderNo WHERE id=@NewID
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
