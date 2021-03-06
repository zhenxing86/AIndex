USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kin_friendhref_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- alter date: 2009-02-25
-- Description:	添加友情链接
-- =============================================
CREATE PROCEDURE [dbo].[kin_friendhref_Add]
@caption nvarchar(30),
@href nvarchar(100),
@siteid int
AS
BEGIN
	DECLARE @orderno int
	SELECT @orderno=Max(orderno)+1 FROM kin_friendhref

	IF @orderno IS NULL
	BEGIN
		SET @orderno=0
	END

	INSERT INTO kin_friendhref VALUES(@caption,@href,@siteid,@orderno)
    exec [kweb_site_RefreshIndexPage] @siteid

	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kin_friendhref_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
