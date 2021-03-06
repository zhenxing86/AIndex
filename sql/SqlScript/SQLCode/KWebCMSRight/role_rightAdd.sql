USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_rightAdd]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	为指定角色分配权限
-- =============================================
CREATE PROCEDURE [dbo].[role_rightAdd]
@role_id int,
@right_id int
AS
IF EXISTS(SELECT * FROM sac_role_right 
        WHERE role_id=@role_id AND right_id=@right_id)
RETURN 0
ELSE
BEGIN
 INSERT INTO
     sac_role_right(role_id,right_id)
  VALUES(@role_id,@right_id)
RETURN @@IDENTITY
END
GO
