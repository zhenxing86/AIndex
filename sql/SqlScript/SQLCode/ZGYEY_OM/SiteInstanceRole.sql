USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRole]    Script Date: 2014/11/24 23:34:44 ******/
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
