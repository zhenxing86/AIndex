USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	获取域名数量
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_GetCount]
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site_domain WHERE siteid=@siteid
	RETURN @count
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_domain_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
