USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[jzxxuser_headpicupdate]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-08-06    
-- Description: 修改头个    
-- Memo:    
*/     
CREATE PROCEDURE [dbo].[jzxxuser_headpicupdate]    
 @userid int = 0,    
 @headpic nvarchar(200)  
 AS      
BEGIN    
 SET NOCOUNT ON    
     
declare  @useridtag int  
 SELECT @useridtag= userid FROM BasicData..[user] WHERE userid =@userid  
   if(isnull(@useridtag,0)<1)  
 return -1  
 Begin tran       
 BEGIN TRY      
  UPDATE BasicData..[user]  
   SET headpic = @headpic,    
     headpicupdate = getdate()    
   WHERE userid = @userid  
     
  Commit tran                                  
 End Try          
 Begin Catch          
  Rollback tran       
  Return -1            
 end Catch        
  Return 1           
        
END 
GO
