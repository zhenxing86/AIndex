USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：广告 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_GetModel]
@advertiseid int
AS 
	SELECT 
		advertiseid,titile,links,filepath,filename,position,filetype,isshow,orderno,status,begintime,endtime,createdatetime
	 FROM [advertise] WHERE advertiseid=@advertiseid

GO
