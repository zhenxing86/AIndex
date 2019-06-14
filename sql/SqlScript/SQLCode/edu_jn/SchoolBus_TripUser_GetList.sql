USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_TripUser_GetList]    Script Date: 2014/11/24 23:05:18 ******/
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
	t.id,tid,t.userid,inuserid,intime,parent_confirm,confirm_time,deletetag,u.[name]
	 FROM [SchoolBus_TripUser] t
inner join BasicData..user_baseinfo u on t.userid=u.userid 
where tid=@tid and deletetag=1












GO
