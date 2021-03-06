USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[advertise_GetListByPosition]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询广告列表 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[advertise_GetListByPosition]
@position int,
@count int
AS 
	SELECT top(@count)
		advertiseid,titile,links,filepath,filename,filetype,orderno,createdatetime
	 FROM [advertise] WHERE position=@position and status=1  and isshow=1 ORDER BY orderno ASC
GO
