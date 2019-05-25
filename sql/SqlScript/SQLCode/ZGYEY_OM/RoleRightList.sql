USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleRightList]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：选择角色权限 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
create PROCEDURE [dbo].[RoleRightList]
@role_id int
AS 
BEGIN
	select id,right_id from sac_role_right where role_id=@role_id
END


GO
