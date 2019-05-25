USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themesetting_Update2]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[site_themesetting_Update2]
@siteid int,
@themeid int

AS
BEGIN
	UPDATE site_themesetting 
	SET themeid2=@themeid,styleid=-1
	WHERE siteid=@siteid AND iscurrent=1

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themesetting_Update2', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
