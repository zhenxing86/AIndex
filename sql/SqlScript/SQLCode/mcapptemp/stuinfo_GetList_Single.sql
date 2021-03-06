USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_GetList_Single]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*    
-- Author:      xie  
-- Create date: 2013-10-26    
-- Description: 根据kid、cid获取用户基础信息  
-- Memo:      
exec mcapp..stuinfo_GetList_Single 1,10,'',-1,19536,''     
*/    
--     
CREATE PROCEDURE [dbo].[stuinfo_GetList_Single]      
 @cid int,    
 @kid int   
 AS    
BEGIN    
 SET NOCOUNT ON     
        
  IF @cid <> -1   
  begin  
 select userid,name,cid,cname from   
   BasicData..user_Child uc    
    where uc.kid = @kid and uc.cid= @cid  
  end  
  else  
  begin  
 select userid,name,cid,cname from   
   BasicData..user_Child uc    
    where uc.kid = @kid  
  end  
    
 end  
    
    
GO
