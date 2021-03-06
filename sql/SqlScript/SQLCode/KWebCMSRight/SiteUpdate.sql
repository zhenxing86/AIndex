USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteUpdate]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-7-28
-- Description:	站点修改
-- =============================================
CREATE PROCEDURE [dbo].[SiteUpdate]
@site_id int,
@site_name nvarchar(50)
AS
UPDATE
   sac_site
SET
   site_name=@site_name
WHERE
   site_id=@site_id
RETURN @@ROWCOUNT
GO
