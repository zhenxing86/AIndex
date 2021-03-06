USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightUpdate]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightUpdate]
@right_id int,
@site_id int,
@site_instance_id int,
@right_name nvarchar(100),
@right_code nvarchar(100)
AS
UPDATE
    sac_site_right
SET site_id=@site_id,
    site_instance_id=@site_instance_id,
    right_name=@right_name,
    right_code=@right_code
WHERE right_id=@right_id
RETURN @@ROWCOUNT
GO
