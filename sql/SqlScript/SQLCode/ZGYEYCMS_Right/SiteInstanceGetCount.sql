USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceGetCount]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	获得站点实例列表数量
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceGetCount]
@org_id int,
@site_id int,
@site_instance_name nvarchar(50)
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM sac_site_instance
    WHERE    
      org_id=CASE @org_id WHEN 0 THEN org_id ELSE @org_id END     
      AND site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
        AND site_instance_name LIKE '%'+@site_instance_name+'%'
    RETURN @count
END
GO
