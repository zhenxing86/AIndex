USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[site_checkByName]    Script Date: 2014/11/24 23:34:44 ******/
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
