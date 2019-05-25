USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_GetListByUserid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途:取个人接送卡数据
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendance_GetListByUserid]
@userid int,
@begintime datetime,
@endtime datetime
AS
	select userid,checktime,kid,cardno,usertype,id 
	from attendance where userid=@userid and checktime>=@begintime and checktime<=@endtime
    order by checktime 





GO
