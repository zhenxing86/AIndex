USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceGetBySite]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceGetBySite]
@site_id int
AS
SELECT site_instance_id,site_instance_name
FROM sac_site_instance
WHERE site_id=@site_id



GO
