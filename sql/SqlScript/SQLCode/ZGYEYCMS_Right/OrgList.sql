USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgList]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老	
-- Create date: 2010-10-27
-- Description:	不分页获取所有组织
-- =============================================
CREATE PROCEDURE [dbo].[OrgList]

AS
SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,o_name
 FROM sac_org a 
left join (select org_id,org_name as o_name from sac_org) b on a.up_org_id=b.org_id
GO
