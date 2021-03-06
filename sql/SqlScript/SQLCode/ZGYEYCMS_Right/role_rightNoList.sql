USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightNoList]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	站点实例下指定角色没有分配的权限
-- =============================================
CREATE PROCEDURE [dbo].[role_rightNoList]
@site_id int,
@site_instance_id int,
@role_id int,
@right_id int
AS
SELECT
   right_id,right_name,right_code,up_right_id
FROM
   sac_right
WHERE
   site_id=@site_id AND site_instance_id=@site_instance_id
   AND up_right_id=@right_id
GO
