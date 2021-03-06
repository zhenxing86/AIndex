USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[GetOrgidBySiteid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-16
-- Description:	根据站点ID获取组织ID
-- =============================================
CREATE PROCEDURE [dbo].[GetOrgidBySiteid]
@siteid int
AS
BEGIN
DECLARE @result int
SELECT @result=org_id FROM site WHERE siteid=@siteid
RETURN @result
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetOrgidBySiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
