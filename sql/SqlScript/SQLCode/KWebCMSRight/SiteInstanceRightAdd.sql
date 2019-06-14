USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightAdd]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightAdd] 
@site_id int,
@site_instance_id int,
@right_name nvarchar(100),
@right_code nvarchar(100)
AS
INSERT INTO sac_site_right
(site_id,site_instance_id,right_name,right_code)
VALUES
(@site_id,@site_instance_id,@right_name,@right_code)
RETURN @@IDENTITY
GO
