USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgCheck]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-17
-- Description:	组织查询
-- =============================================
CREATE PROCEDURE [dbo].[OrgCheck] 
@org_name nvarchar(50)
AS
SELECT org_id,org_name,up_org_id
FROM sac_org
WHERE org_name like '%'+@org_name+'%'
GO
