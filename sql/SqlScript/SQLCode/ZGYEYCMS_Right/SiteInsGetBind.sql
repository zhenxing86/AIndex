USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInsGetBind]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：站点实例绑定
--项目名称：Right
--说明：
--时间：2010-3-31 17:49:11
------------------------------------
create PROCEDURE [dbo].[SiteInsGetBind]
 AS 
	SELECT 	site_instance_id,site_instance_name FROM [sac_site_instance]
GO
