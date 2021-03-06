USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetCount]    Script Date: 2014/11/24 23:34:44 ******/
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
