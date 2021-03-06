USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[site_checkByName]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	站点查询
-- =============================================
CREATE PROCEDURE [dbo].[site_checkByName]
@site_name nvarchar(50)
AS
SELECT 
    site_id,site_name
FROM
    sac_site
WHERE
    site_name like '%'+@site_name+'%'
GO
