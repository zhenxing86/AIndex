USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceBind]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-11-2
-- Description:	获取站点
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceBind] 
@site_instance_name nvarchar(50)
AS
SELECT site_instance_id,site_instance_name
FROM sac_site_instance
WHERE site_instance_name=@site_instance_name
GO
