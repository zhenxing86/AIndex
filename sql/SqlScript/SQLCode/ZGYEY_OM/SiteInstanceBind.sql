USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceBind]    Script Date: 2014/11/24 23:34:44 ******/
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
