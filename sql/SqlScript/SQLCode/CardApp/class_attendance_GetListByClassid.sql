USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_GetListByClassid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------  
--用途:取班级接送卡数据  
--项目名称：classhomepage  
--说明：  
--时间：2009-7-18 14:54:31  
memo

class_attendance_GetListByClassid 
@classid =81106,
@begintime ='2014-06-03 00:00:00',
@endtime='2014-06-03 23:00:00'
------------------------------------ */ 
CREATE PROCEDURE [dbo].[class_attendance_GetListByClassid]  
 @classid int,  
 @begintime datetime,  
 @endtime datetime  
AS  
BEGIN  
 --select u.userid, u.name, a.checktime,a.id, a.kid, a.cardno, a.usertype, a.uploadtime   
 -- From basicdata.dbo.[user] u   
 --  inner join basicdata.dbo.user_class uc on u.userid = uc.userid  
 --  left join attendance a on uc.userid = a.userid  
 -- where uc.cid = @classid   
 --  and u.deletetag = 1   
 --  and u.usertype = 0   
 --  and a.checktime >= @begintime   
 --  and a.checktime <= @endtime  
 -- order by a.checktime 
  
  select u.userid, u.name, a.cdate,-1, a.kid, '', 0, a.cdate   
  From basicdata.dbo.[user] u   
   inner join basicdata.dbo.user_class uc on u.userid = uc.userid  
   left join mcapp..stu_at_all_V a on uc.userid = a.stuid  
  where uc.cid = @classid   
   and u.deletetag = 1   
   and u.usertype = 0   
   and a.cdate >= @begintime   
   and a.cdate <= @endtime  
  order by a.cdate  
END  


 
GO
