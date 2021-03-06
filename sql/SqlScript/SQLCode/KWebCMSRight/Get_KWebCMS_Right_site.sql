USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[Get_KWebCMS_Right_site]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2011-7-26
-- Description:	获取组织id，站点实例id，站点id
-- =============================================
CREATE PROCEDURE [dbo].[Get_KWebCMS_Right_site] 
@kid int
AS

	select t2.org_id,t2.site_instance_id,t2.site_id
	from kwebcms.dbo.[site] t1 inner join sac_site_instance t2 on t1.org_id=t2.org_id and site_id=1
	where t1.siteid=@kid
GO
