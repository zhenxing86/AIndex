USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_TripUser_Delete]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/3/2 17:35:05
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_TripUser_Delete]
@tid int
 AS 
	DELETE [SchoolBus_TripUser]
	 WHERE tid=@tid


GO
