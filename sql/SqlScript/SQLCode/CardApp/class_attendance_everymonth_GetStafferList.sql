USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_everymonth_GetStafferList]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：查询老师接送记录月表     
--项目名称：classhomepage    
--说明：    
--时间：2010-5-10 15:50:10    
--[class_attendance_everymonth_GetStafferList] 9020,7525,2013,3    
------------------------------------    
CREATE PROCEDURE [dbo].[class_attendance_everymonth_GetStafferList]    
@deptid int,    
@kid int,    
@year int,    
@month int    
 AS     
IF(@deptid=0)    
BEGIN    
 SELECT     
 t1.kid,t1.cardno,t1.userid,t1.deptid,t1.classid,t1.usertype,t1.year,t1.month,t1.days,    
 t1.day_1,t1.day_2,t1.day_3,t1.day_4,t1.day_5,t1.day_6,t1.day_7,t1.day_8,    
 t1.day_9,t1.day_10,t1.day_11,t1.day_12,t1.day_13,t1.day_14,t1.day_15,t1.day_16,    
 t1.day_17,t1.day_18,t1.day_19,t1.day_20,t1.day_21,t1.day_22,t1.day_23,t1.day_24,    
 t1.day_25,t1.day_26,t1.day_27,t1.day_28,t1.day_29,t1.day_30,t1.day_31,t3.name    
  FROM  basicdata.dbo.[user] t3     
   inner join basicdata.dbo.teacher t4 on t3.userid=t4.userid    
   LEFT JOIN attendance_everymonth t1 on (t1.userid=t3.userid and t1.[year]=@year and t1.[month]=@month)    
 WHERE T3.kid=@kid and t3.deletetag=1     
 ORDER BY t3.userid    
END    
ELSE    
BEGIN    
 SELECT     
 t1.kid,t1.cardno,t1.userid,t1.deptid,t1.classid,t1.usertype,t1.year,t1.month,t1.days,    
 t1.day_1,t1.day_2,t1.day_3,t1.day_4,t1.day_5,t1.day_6,t1.day_7,t1.day_8,    
 t1.day_9,t1.day_10,t1.day_11,t1.day_12,t1.day_13,t1.day_14,t1.day_15,t1.day_16,    
 t1.day_17,t1.day_18,t1.day_19,t1.day_20,t1.day_21,t1.day_22,t1.day_23,t1.day_24,    
 t1.day_25,t1.day_26,t1.day_27,t1.day_28,t1.day_29,t1.day_30,t1.day_31,T3.name    
  FROM  basicdata.dbo.[user] t3     
   inner join basicdata.dbo.teacher t4 on T3.userid=t4.userid    
   LEFT JOIN attendance_everymonth t1 on (t1.userid=T3.userid and t1.[year]=@year and t1.[month]=@month)    
 WHERE  t3.deletetag=1 and t4.did=@deptid  and t3.kid>0  
 ORDER BY T3.userid    
END 
GO
