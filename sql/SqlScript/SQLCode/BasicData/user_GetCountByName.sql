USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetCountByName]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-07-16    
-- Description: 得到用户数    
-- Memo:      
EXEC  user_GetCountByName '', 12511,0  
EXEC  user_GetCountByName '', 12511,1  
*/  
CREATE PROCEDURE [dbo].[user_GetCountByName]  
 @name NVARCHAR(20),  
 @kid  int,  
 @usertype int  
AS  
BEGIN  
 SET NOCOUNT ON   
 declare @count int  
 if(@usertype=1)  
 begin  
  SELECT @count=count(1)  
   FROM [user] u   
    inner join teacher t on u.userid = t.userid  
    left join leave_kindergarten lk on u.userid = lk.userid  
   WHERE u.usertype >= 1   
    and u.deletetag = 1    
    and u.kid = @kid   
    and u.usertype <> 98  
    and u.name like @name+'%'   
    and lk.userid is null  
 end  
 else  
 begin  
  SELECT @count=COUNT(1)  
   FROM [user_child] u 
    inner join BasicData..child d on u.userid= d.userid   
    left join leave_kindergarten lk on u.userid = lk.userid  
   WHERE u.kid = @kid   
    and u.name like @name+'%'   
    and lk.userid is null  
 end  
 select @count  
 RETURN @count  
END  
GO
