USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetModel]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	获取修改绑定信息
-- =============================================
CREATE PROCEDURE [dbo].[OrgGetModel]
@org_id int
AS
BEGIN   
  SELECT a.[org_id],a.org_name,create_datetime,a.up_org_id,o_name
        FROM sac_org a 
   left join (select org_id,org_name as o_name from sac_org) b 
    on a.up_org_id=b.org_id
    WHERE a.[org_id]=@org_id
END



GO
