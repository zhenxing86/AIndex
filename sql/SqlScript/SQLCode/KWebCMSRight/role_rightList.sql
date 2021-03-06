USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	获取指定角色权限列表>
-- =============================================
CREATE PROCEDURE [dbo].[role_rightList]
@role_id int,
@right_id int
AS
SELECT
    sac_right.right_id,right_name,right_code,up_right_id
FROM
    sac_right
INNER JOIN
    sac_role_right
ON
    sac_right.right_id=sac_role_right.right_id
WHERE
    role_id=@role_id AND up_right_id=@right_id
GO
