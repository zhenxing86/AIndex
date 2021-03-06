USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kin_friendhref_orderno_asc]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	指定友情链接排序号 + 1
-- =============================================
CREATE PROCEDURE [dbo].[kin_friendhref_orderno_asc]
@id int 
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	DECLARE @currentsiteid int
	SELECT @currentOrderNo=orderno,@currentsiteid=siteid FROM kin_friendhref WHERE id=@id

	DECLARE @NewOrderNo int
	DECLARE @NewID int
	SELECT TOP 1 @NewID=id,@NewOrderNo=orderno FROM kin_friendhref WHERE siteid=@currentsiteid AND orderno>@currentOrderNo ORDER BY orderno ASC
	

	exec [kweb_site_RefreshIndexPage] @currentsiteid

	IF @NewOrderNo IS NULL OR @NewID IS NULL
	BEGIN
		COMMIT TRANSACTION
		RETURN 2 --己经是最高
	END

	UPDATE kin_friendhref SET orderno=@NewOrderNo WHERE id=@id
	
	UPDATE kin_friendhref SET orderno=@currentOrderNo WHERE id=@NewID

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
