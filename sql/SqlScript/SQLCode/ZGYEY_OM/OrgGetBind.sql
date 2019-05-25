USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetBind]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	查询上级组织
-- =============================================
CREATE procedure [dbo].[OrgGetBind]
@org_name nvarchar(30)
as
begin
     select org_id,org_name,up_org_id from sac_org 
       where org_name=@org_name
end



GO
