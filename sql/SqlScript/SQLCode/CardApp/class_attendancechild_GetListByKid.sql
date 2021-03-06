USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendancechild_GetListByKid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途:取幼儿园小孩接送卡数据
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendancechild_GetListByKid]
	@kid int,
	@begintime datetime,
	@endtime datetime
AS
	select u.userid, u.name, a.checktime 
		From basicdata.dbo.[user] u 
			left join attendance a on u.userid = a.userid
		where u.kid = @kid 
			and u.deletetag = 1 
			and u.usertype = 0 
			and a.checktime >= @begintime 
			and a.checktime <= @endtime
		order by u.userid

GO
