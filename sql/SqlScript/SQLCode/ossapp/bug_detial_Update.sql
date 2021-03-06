USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[bug_detial_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                
-- Author:      xie          
-- Create date: 2013-12-06            
-- Description:                 
-- Memo:                  
exec bug_detial_Update 1               
*/                
CREATE PROCEDURE [dbo].[bug_detial_Update]                 
@id int,           
@douserid int,       
@dosuggestion nvarchar(max)  
 AS   
   
 declare @bugid int                   
begin                
    SET NOCOUNT ON      
          
    begin tran      
    begin try      
          
		select @bugid=bugid
		  from bug_detial   
		   where id=@id  
	      
		update ossapp..bug_detial       
		  set suggestion = @dosuggestion
		   where id=@id      
	            
		update b       
		  set doresult=@dosuggestion,dodate=GETDATE()  
		  from  ossapp..buginfo b      
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
