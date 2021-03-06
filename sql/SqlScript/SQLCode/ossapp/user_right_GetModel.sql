USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[user_right_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie
-- Create date: 2014-04-02  
-- Description: 根据userid获取用户权限Model  
-- Memo:    
exec user_right_GetModel 295765 
*/  
create PROCEDURE [dbo].[user_right_GetModel]  
@userid int    
 AS   
begin  
 set nocount on
 
  select 1,u.kid,k.kname,userid,name,account,usertype,
   u.deletetag,mobile,ReadRight,lqRight  
   from BasicData..[user] u 
    inner join BasicData..kindergarten k 
     on u.kid = k.kid
   where userid = @userid
  
end  
GO
