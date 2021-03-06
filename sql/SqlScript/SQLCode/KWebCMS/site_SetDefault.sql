USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_SetDefault]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	设为默认域名
-- =============================================
CREATE PROCEDURE [dbo].[site_SetDefault]
@id int,
@siteid int
AS
BEGIN
	UPDATE site SET sitedns=(SELECT domain FROM site_domain WHERE id=@id) WHERE siteid=@siteid

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_SetDefault', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
