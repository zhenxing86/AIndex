USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-04
-- Description:	获取站点实体
-- =============================================
CREATE PROCEDURE [dbo].[kweb_site_GetModel]
@siteid int
AS
BEGIN
	SELECT s.[name],s.description,s.address,s.sitedns,s.provice,s.city,s.regdatetime,s.contractname,s.QQ,s.phone,s.accesscount,s.status,k.shortname,s.keyword
	FROM [site] s LEFT JOIN site_config  k
	ON s.siteid=k.siteid
	WHERE s.siteid=@siteid and k.siteid=@siteid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_site_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
