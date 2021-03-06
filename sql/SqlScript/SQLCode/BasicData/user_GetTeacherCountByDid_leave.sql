USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherCountByDid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------ 
-- Author:     xie
--用途：得到离园教师数   
--项目名称：  
--说明：  
--时间：2014-4-16 16:57:46  
--[user_GetTeacherCountByDid_leave] 79101  
------------------------------------  
CREATE PROCEDURE [dbo].[user_GetTeacherCountByDid_leave]  
@did int  
 AS   
 declare @count int  
 SELECT  
  @count =COUNT(1)  
 FROM  
  [user] t1 
  Inner JOIN [teacher] t2 
   on t1.userid=t2.userid  
  left join leave_kindergarten lk 
   on t1.userid = lk.userid  
 WHERE  
  t2.did in  (select did from get_department_subsid(@did))   
 and t1.deletetag=1 and t1.usertype<>0  and t1.usertype<>98  
 and (t1.kid =0 or t1.kid is null)
 and lk.userid is not null
 select @count  
 RETURN @count  
GO
