USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[bug_detial_Add]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      xie      
-- Create date: 2013-11-28            
-- Description:             
-- Memo:              
exec bug_detial_Add 1           
*/            
CREATE PROCEDURE [dbo].[bug_detial_Add]             
@bugid int,       
@douserid int,   
@suggestion nvarchar(max),    
@process int,
@reasonlevel int =0 
 AS             
begin            
    SET NOCOUNT ON  
      
    begin tran  
    begin try  
      
	  insert into bug_detial(bugid,suggestion,douserid,dodate,ftype)   
	   select @bugid,@suggestion,@douserid,GETDATE(),
	    (case when userid=@douserid then 0 when douserid=@douserid then 1 else 2 end ) ftype
	    from buginfo  
	    where bugid=@bugid
	      
	  update b   
	   set doresult=@suggestion,
	   dodate = GETDATE(),  
	   process = @process,
	   reason_level=@reasonlevel 
	   from  buginfo b  
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
