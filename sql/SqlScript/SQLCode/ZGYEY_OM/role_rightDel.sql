USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightDel]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	删除角色指定权限
-- =============================================
CREATE PROCEDURE [dbo].[role_rightDel] 
@role_id int,
@right_id int
AS
DELETE FROM
     sac_role_right
WHERE
     role_id=@role_id AND right_id=@right_id
RETURN @@ROWCOUNT



GO
