USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_GetListByDepartmentid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途:取老实卡数据  
--项目名称：classhomepage  
--说明：  
--时间：2009-7-18 14:54:31  
------------------------------------  
CREATE PROCEDURE [dbo].[class_attendance_GetListByDepartmentid]  
 @departmentid int,  
 @kid int,  
 @begintime datetime,  
 @endtime datetime  
AS  
--IF(@departmentid=0)  
--BEGIN  
-- select u.userid, u.name, a.checktime,at.time1,at.time2,at.time3,at.time4,at.time5,at.time6   
--  From basicdata.dbo.[user] u   
--  inner join basicdata.dbo.teacher t on u.userid=t.userid  
--  left join  attendance  a on t.userid = a.userid  
--  left join attendancetimeset at on t.did = at.departmentid  
--  where at.kid=@kid   
--  and a.checktime >=@begintime   
--  and a.checktime<=@endtime  
--  order by a.checktime  
--END  
--ELSE  
--BEGIN  
-- select u.userid, u.name, a.checktime,at.time1,at.time2,at.time3,at.time4,at.time5,at.time6   
--  From basicdata.dbo.[user] u   
--  inner join basicdata.dbo.teacher t on u.userid=t.userid  
--  left join attendance a on t.userid = a.userid  
--  left join attendancetimeset at on t.did = at.departmentid  
--  where at.kid=@kid   
--  and at.departmentid=@departmentid   
--  and a.checktime >=@begintime   
--  and a.checktime<=@endtime  
--  order by a.checktime  
--END  

IF(@departmentid=0)  
BEGIN  
 select u.userid, u.name, a.cdate,at.time1,at.time2,at.time3,at.time4,at.time5,at.time6   
  From basicdata.dbo.[user] u   
  inner join basicdata.dbo.teacher t on u.userid=t.userid  
  left join mcapp..tea_at_all_V a on t.userid = a.teaid  
  left join attendancetimeset at on t.did = at.departmentid  
  where at.kid=@kid   
  and a.cdate >=@begintime   
  and a.cdate<=@endtime  
  order by a.cdate  
END  
ELSE  
BEGIN  
 select u.userid, u.name, a.cdate,at.time1,at.time2,at.time3,at.time4,at.time5,at.time6   
  From basicdata.dbo.[user] u   
  inner join basicdata.dbo.teacher t on u.userid=t.userid  
  left join mcapp..tea_at_all_V a on t.userid = a.teaid  
  left join attendancetimeset at on t.did = at.departmentid  
  where at.kid=@kid   
  and at.departmentid=@departmentid   
  and a.cdate >=@begintime   
  and a.cdate<=@endtime  
  order by a.cdate  
END



GO
