USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightCount]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightCount] 
@site_id int,
@site_instance_id int
AS
DECLARE @count int
SELECT @count=COUNT(right_id) FROM sac_site_right
WHERE 
    site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
AND site_instance_id=CASE @site_instance_id WHEN 0 THEN site_instance_id ELSE @site_instance_id END
RETURN @count
GO
