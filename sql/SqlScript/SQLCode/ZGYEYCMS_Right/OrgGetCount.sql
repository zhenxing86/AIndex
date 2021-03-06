USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetCount]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	获得组织数量
-- =============================================
CREATE PROCEDURE [dbo].[OrgGetCount]
@org_name nvarchar(30)
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM sac_org 
      WHERE org_name like '%'+@org_name+'%'
    RETURN @count
END
GO
