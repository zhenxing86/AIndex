USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherByDid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie       
-- Create date: 2014-04-16        
-- Description:  得到离园老师列表       
-- Memo:        
user_GetTeacherByDid_leave 26216      
*/      
CREATE PROCEDURE [dbo].[user_GetTeacherByDid_leave]      
 @did int      
AS      
BEGIN        
 SET NOCOUNT ON      
 SELECT u.userid, u.account, u.name, u.gender, u.mobile      
  FROM [user] u     
  Inner JOIN [teacher] t     
   on u.userid=t.userid  
   left join leave_kindergarten lk on u.userid = lk.userid      
  WHERE u.usertype <> 98      
   and t.did in (select did from get_department_subsid(@did))      
   AND (u.kid = 0 or u.kid is null)         
   and lk.userid is not null      
  ORDER BY u.userid DESC      
END      
GO
