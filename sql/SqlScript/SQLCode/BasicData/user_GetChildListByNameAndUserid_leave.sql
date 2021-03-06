USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildListByNameAndUserid_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-07-16    
-- Description: 得到用户列表    
-- Memo:      
EXEC  user_GetChildListByNameAndUserid_leave '',295765,1,10  
*/   
CREATE PROCEDURE [dbo].[user_GetChildListByNameAndUserid_leave]  
 @name nvarchar(20),  
 @userid  int,  
 @page int,  
 @size int  
AS   
BEGIN  
 SET NOCOUNT ON  
 DECLARE @beginRow INT  
 DECLARE @endRow INT  
 DECLARE @pcount INT  
 SET @beginRow = (@page - 1) * @size    + 1  
 SET @endRow = @page * @size   
  
 SELECT  userid, account, name, gender, mobile,leavereason 
  FROM   
  (  
   SELECT ROW_NUMBER() OVER(order by u.regdatetime desc) AS rows,   
       u.userid,u.account,u.name,u.gender,u.mobile,t5.leavereason  
    FROM [user] u   
     left join leave_kindergarten t5 on u.userid = t5.userid  
    WHERE u.usertype = 0    
     and t5.userid = @userid   
     and u.name like @name+'%'  
     and t5.userid is not null  
     and u.deletetag=1  
  ) AS main_temp   
  WHERE rows BETWEEN @beginRow AND @endRow  
END  
GO
