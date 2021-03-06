USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetCountByName_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-07-16    
-- Description: 得到用户数    
-- Memo:   
declare   @count int   
EXEC @count = user_GetCountByName_leave '', 12511,0  
select @count  
EXEC @count = user_GetCountByName_leave '', 11061,1  
select @count  
*/  
CREATE PROCEDURE [dbo].[user_GetCountByName_leave]  
 @name NVARCHAR(20),  
 @kid  int,  
 @usertype int  
AS  
BEGIN  
 SET NOCOUNT ON   
 declare @count int  
 SELECT @count = COUNT(1)  
  FROM [user] u   
  left join leave_kindergarten lk on u.userid = lk.userid  
  WHERE case when u.usertype > 0 then 1 else 0 end = @usertype   
   and lk.kid = @kid   
   and u.name like @name+'%'  
   AND lk.userid is not null 
   AND (u.kid = 0 or u.kid is null)   
   and u.deletetag=1  and u.usertype<>98
 RETURN @count  
END  


GO
