USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[buginfo_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*              
-- Author:      xie        
-- Create date: 2013-12-06          
-- Description:               
-- Memo:                
exec buginfo_DeleteTag 1             
*/              
CREATE PROCEDURE [dbo].[buginfo_DeleteTag]               
@bugid int      
 AS 
          
begin              
    SET NOCOUNT ON      
          
    begin tran      
    begin try      
          
	update ossapp..buginfo
	set deletetag=0 
	 where bugid=@bugid  
	 
	update ossapp..bug_detial
	set deletetag=0 
	 where bugid=@bugid 
	
   commit tran      
   return 1      
    end try      
    begin catch      
  rollback tran      
        return -1      
    end catch  
	
	
	     
end   
  

GO
