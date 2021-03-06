USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_department_sms_GetAllList]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：取所有组织部门  
--项目名称：classhomepage  
--说明：  
--时间：2009-3-3 14:54:31  
------------------------------------  
CREATE PROCEDURE [dbo].[class_department_sms_GetAllList]  
@kid int  
 AS   
 SELECT d.did,dname,superior,COUNT(u.userid)   
   FROM BasicData.dbo.department d  
    left join BasicData..teacher t   
     on d.did=t.did  
    left join BasicData..[user] u  
     on u.userid=t.userid AND u.deletetag=1 and u.usertype>0 and commonfun.dbo.fn_cellphone(u.mobile) = 1  
     left join BasicData..leave_kindergarten l on u.userid=l.userid  
  WHERE d.kid=@kid    
   AND d.deletetag=1    and l.ID is null     
  group by d.did,dname,superior  
  order by COUNT(u.userid)  
  desc  
GO
