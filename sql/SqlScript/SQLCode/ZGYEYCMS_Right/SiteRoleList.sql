USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteRoleList]    Script Date: 05/14/2013 14:58:19 ******/
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
