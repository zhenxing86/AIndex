USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteGetModel]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2010-8-9
-- Description:	获取站点
-- =============================================
CREATE PROCEDURE [dbo].[SiteGetModel] 
@site_id int
AS
     SELECT site_id,site_name FROM sac_site WHERE site_id=@site_id
GO
