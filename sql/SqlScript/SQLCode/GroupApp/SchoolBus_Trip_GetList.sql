USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Trip_GetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/3/2 17:38:04
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Trip_GetList]
@bid int
 AS 
	SELECT 
	0,id,bid,starttime,endtime,route,site,inuserid,intime,deletetag,
(select count(1) from SchoolBus_TripUser where tid=t.id)
	 FROM [SchoolBus_Trip] t where  deletetag=1 and bid=@bid



GO
