USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRole]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRole]
@site_instance_id int
AS
SELECT role_id,site_id,site_instance_id,role_name
FROM sac_role
WHERE site_instance_id=@site_instance_id
GO
