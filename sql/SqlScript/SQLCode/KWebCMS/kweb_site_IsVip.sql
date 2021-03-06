USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_IsVip]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-12
-- Description:	是否是VIP幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[kweb_site_IsVip]
@siteid int
AS
BEGIN
	IF EXISTS(SELECT isvip FROM kmp..T_Kindergarten WHERE id=@siteid AND isvip=1 and status=1)
	BEGIN
		RETURN 1
	END
	ELSE
	BEGIN
		RETURN 0
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_site_IsVip', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
