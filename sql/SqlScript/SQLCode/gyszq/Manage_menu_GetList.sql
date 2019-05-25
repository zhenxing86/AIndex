USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_menu_GetList]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取管理中心菜单记录列表
--项目名称：ServicePlatformManage
--说明：
--时间：2008-12-8 16:15:25
------------------------------------
CREATE PROCEDURE [dbo].[Manage_menu_GetList]
 AS 	
	SELECT 
	id,title,url,target,parentid,imageurl,orderno
	 FROM manage_menu
	ORDER BY orderno
GO
