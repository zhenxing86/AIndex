USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_GetModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie  
-- Create date: 2014-04-02    
-- Description: 根据kid获取幼儿园晨检短信权限 Model    
-- Memo:      
sendset：1位：入园，2位：离园，3位：晨检正常短信
exec kindergarten_GetModel 12511   
*/    
CREATE PROCEDURE [dbo].[kindergarten_GetModel]    
@kid int      
 AS     
begin    
 set nocount on  
   
  select 1,bk.kid,bk.kname,mk.sendset     
   from basicdata..kindergarten bk
     left join mcapp..kindergarten mk
      on bk.kid=mk.kid and bk.deletetag=1 
      where bk.kid=@kid
    
end  
GO
