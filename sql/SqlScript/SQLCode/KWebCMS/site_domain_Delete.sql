USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	删除域名
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_Delete]
@id int
AS
BEGIN
	DELETE site_domain WHERE id=@id

	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END




GO
