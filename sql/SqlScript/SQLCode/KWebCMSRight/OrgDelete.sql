USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgDelete]    Script Date: 05/14/2013 14:53:16 ******/
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
