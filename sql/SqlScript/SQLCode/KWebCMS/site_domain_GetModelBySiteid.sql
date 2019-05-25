USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetModelBySiteid]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create  PROCEDURE [dbo].[site_domain_GetModelBySiteid]
@siteid int 
AS
BEGIN
	SELECT * FROM site_domain WHERE siteid=@siteid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_domain_GetModelBySiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
