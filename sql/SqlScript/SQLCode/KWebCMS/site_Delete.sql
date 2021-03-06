USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-19
-- Description:	删除站点
-- =============================================
CREATE PROCEDURE [dbo].[site_Delete]
@siteid int
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE site SET status=0 WHERE siteid=@siteid
	update basicdata..kindergarten set deletetag=0 where kid=@siteid
    
    
	IF @@Error<>0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END
END







GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_Delete', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
