USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetProviceAndCity]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date:  2000
-- Description:	Kwebcms根据站点ID,查询对应的身份和城市ID
-- =============================================
CREATE PROCEDURE  [dbo].[site_GetProviceAndCity]
	@siteid int
AS
BEGIN
	 select provice,city,dict,ktype,klevel from site where siteid=@siteid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_GetProviceAndCity', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
