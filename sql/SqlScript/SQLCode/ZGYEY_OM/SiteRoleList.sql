USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteRoleList]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：选择站点角色 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
create PROCEDURE [dbo].[SiteRoleList]
@site_id int
AS 
BEGIN
	select role_id from sac_role where [site_id]=@site_id
END



GO
