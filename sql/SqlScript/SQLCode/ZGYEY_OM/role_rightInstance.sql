USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightInstance]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-31
-- Description:	获取指定站点实例所有权限
-- =============================================
CREATE PROCEDURE [dbo].[role_rightInstance]
@site_id int,
@site_instance_id int
AS
SELECT
   right_id,right_name,right_code,up_right_id
FROM
   sac_right
WHERE
   site_id=@site_id AND 
   site_instance_id=@site_instance_id OR site_instance_id=0
ORDER BY right_id


GO
