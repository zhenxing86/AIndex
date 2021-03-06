USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_staffer_GetListByDepartmentid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途:取教师列表  
--项目名称：classhomepage  
--说明：  
--时间：2009-7-18 14:54:31  cardapp

------------------------------------  
CREATE PROCEDURE [dbo].[class_staffer_GetListByDepartmentid]  
 @departmentid int,  
 @kid int  
AS  
IF(@departmentid=0)  
BEGIN  
 select u.userid,u.name,t.did   
 From basicdata.dbo.[user] u   
 inner join basicdata.dbo.teacher t on u.userid = t.userid  
  where u.kid = @kid 
  and u.deletetag = 1   
  order by u.regdatetime desc  
END  
ELSE  
BEGIN  
 select u.userid,u.name,t.did   
 From basicdata.dbo.[user] u   
 inner join basicdata.dbo.teacher t on u.userid = t.userid  
  where u.kid = @kid 
  and u.deletetag = 1   
  and t.did = @departmentid   
  order by u.regdatetime desc  
END  
GO
