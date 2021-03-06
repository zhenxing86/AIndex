USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherListByDid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie
-- Create date: 2014-04-16  
-- Description: 得到离园教师列表  
-- Memo:    
exec [user_GetTeacherListByDid_leave] 26216,1,10  
*/   
/*        
-- Author:      xie      
-- Create date: 2014-04-16        
-- Description: 得到离园教师列表        
-- Memo:          
exec [user_GetTeacherListByDid_leave] 138120,1,13        
*/         
CREATE PROCEDURE [dbo].[user_GetTeacherListByDid_leave]        
 @did int,        
 @page int,        
 @size int        
AS         
BEGIN         
 SET NOCOUNT ON        
 DECLARE @beginRow INT        
 DECLARE @endRow INT            
        
 SET @beginRow = (@page - 1) * @size    + 1        
 SET @endRow = @page * @size          
         
  SELECT m.userid, m.account, m.name, m.gender, m.mobile      
  FROM         
    (        
     SELECT ROW_NUMBER() OVER(order by t.orderno ,t.title) AS rows,          
         u.userid,u.account,u.name,u.gender,u.mobile        
      FROM [Teacher] t   
        inner join [user] u on t.userid = u.userid      
        INNER JOIN get_department_subsid(@did)g         
         ON t.did = g.did        
        left join leave_kindergarten lk       
         on t.userid = lk.userid        
      WHERE u.usertype <> 98 and u.deletetag=1     
       AND (u.kid = 0 or u.kid is null)        
       and lk.userid is not null           
    ) AS m         
  WHERE rows BETWEEN @beginRow AND @endRow        
           
       
END 

      
GO
