USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgDelete]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	删除组织
-- =============================================
CREATE PROCEDURE [dbo].[OrgDelete]
@org_id int
 AS
IF EXISTS(SELECT * FROM sac_org WHERE up_org_id=@org_id)
RETURN 0
ELSE
BEGIN
	DELETE from [sac_org] WHERE org_id=@org_id --删除组织
    RETURN @@ROWCOUNT
END



GO
