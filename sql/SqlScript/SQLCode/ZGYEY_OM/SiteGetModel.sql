USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteGetModel]    Script Date: 2014/11/24 23:34:44 ******/
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
