USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_TripUser_GetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/3/2 17:35:53
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_TripUser_GetList]
@tid int
 AS 
	SELECT 
	t.id,tid,t.userid,inuserid,intime,parent_confirm,confirm_time,t.deletetag,u.[name]
	 FROM [SchoolBus_TripUser] t
inner join BasicData..[user] u on t.userid=u.userid  
where tid=@tid and t.deletetag=1

GO
