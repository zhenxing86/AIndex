USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[GetLoginUsers]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie      
-- Create date: 2014-04-30      
-- Description: 获取采集器登录用户列表    
-- Memo:         
exec GetLoginUsers         
 @kid = 12511       
*/        
CREATE PROCEDURE [dbo].[GetLoginUsers]         
 @kid int    
AS         
BEGIN        
 SET NOCOUNT ON        
 select userid,name,[account],[password]         
  from BasicData..[user]    
   where usertype>0 and kid=@kid and deletetag=1    
 union all              
 SELECT [ID],name,[account],[password]       
  FROM ossapp..[users]         
  where deletetag=1 and bid=0 and roleid in (1,2)      
END   
  
  
GO
