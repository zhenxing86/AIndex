USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightSingleInfo]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-5
-- Description:	获取指定权限信息
-- =============================================
CREATE PROCEDURE [dbo].[role_rightSingleInfo]
@right_id int
AS
SELECT
    right_id,up_right_id,right_name,right_code
FROM
    sac_right
WHERE
    right_id=@right_id
GO
