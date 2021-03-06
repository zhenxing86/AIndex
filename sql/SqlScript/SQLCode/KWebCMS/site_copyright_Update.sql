USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_copyright_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	Update
-- =============================================
CREATE PROCEDURE [dbo].[site_copyright_Update]
@siteid int,
@contents ntext
AS
BEGIN
	IF EXISTS (SELECT * FROM site_copyright WHERE siteid=@siteid)
	BEGIN
		UPDATE site_copyright SET contents=@contents WHERE siteid=@siteid
	END
	ELSE
	BEGIN
		INSERT INTO site_copyright VALUES(@siteid,@contents)
	END

	exec [kweb_site_RefreshIndexPage] @siteid


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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_copyright_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
