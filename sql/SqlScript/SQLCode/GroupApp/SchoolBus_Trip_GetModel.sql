USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Trip_GetModel]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/3/2 17:38:04
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Trip_GetModel]
@id int
 AS 
	SELECT 
	id,bid,starttime,endtime,[route],site,inuserid,intime,deletetag
	 FROM [SchoolBus_Trip]
	 WHERE id=@id


GO
