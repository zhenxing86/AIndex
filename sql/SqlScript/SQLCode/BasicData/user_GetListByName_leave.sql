USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetListByName_leave]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-06-20  
-- Description: 得到用户列表  
-- Memo:    
exec user_GetListByName_leave '',12511,1,1,100  
*/   
CREATE PROCEDURE [dbo].[user_GetListByName_leave]  
 @name nvarchar(20),  
 @kid  int,  
 @usertype int,  
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
  
 SELECT userid , account, name , gender, mobile,leavereason 
  FROM   
    (  
     SELECT ROW_NUMBER() OVER(order by u.regdatetime) AS rows,   
         u.userid , account, name , gender, mobile,lk.leavereason  
      FROM [user] u   
      left join leave_kindergarten lk on u.userid = lk.userid  
      WHERE case when u.usertype > 0 then 1 else 0 end = @usertype   
       and lk.kid = @kid   
       and u.name like @name+'%'  
       AND lk.userid is not null  
       and u.deletetag=1 and u.usertype<>98 
       AND (u.kid = 0 or u.kid is null)  
    ) AS main_temp   
  WHERE rows BETWEEN @beginRow AND @endRow  
   
END   
GO
