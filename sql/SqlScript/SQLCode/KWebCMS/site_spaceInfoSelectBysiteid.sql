USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_spaceInfoSelectBysiteid]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:  liaoxin	
-- Create date: 2010-8-1
-- Description:	查询站点ID下的空间信息表。
-- =============================================
CREATE PROCEDURE [dbo].[site_spaceInfoSelectBysiteid]

	@siteid int
AS
BEGIN 
   
	 select spaceSize,lastSize from site_spaceInfo where siteID=@siteid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_spaceInfoSelectBysiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
