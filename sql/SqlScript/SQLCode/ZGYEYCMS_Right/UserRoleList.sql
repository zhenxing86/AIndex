USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[UserRoleList]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：选择用户角色 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
create PROCEDURE [dbo].[UserRoleList]
@user_id int
AS 
BEGIN
	select id,role_id from sac_user_role where [user_id]=@user_id
END
GO
