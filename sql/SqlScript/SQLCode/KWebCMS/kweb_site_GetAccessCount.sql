USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_GetAccessCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	获取网站访问数量
CREATE PROCEDURE [dbo].[kweb_site_GetAccessCount]
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=accesscount FROM site WHERE siteid=@siteid
	IF @count IS NULL
	BEGIN
		SET @count=0
	END
	RETURN @count
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_site_GetAccessCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
