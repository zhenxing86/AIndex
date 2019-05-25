USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleRightList]    Script Date: 05/14/2013 14:53:16 ******/
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
