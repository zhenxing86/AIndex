USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[OrgGetCount]    Script Date: 05/14/2013 14:53:16 ******/
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
@org_name nvarchar(30),
@siteid int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM sac_org 
        INNER JOIN KWebCMS..site ON sac_org.org_id=KWebCMS..site.org_id
      WHERE org_name like '%'+@org_name+'%'
AND siteid=CASE @siteid WHEN 0 THEN siteid ELSE @siteid END
    RETURN @count
END
GO
