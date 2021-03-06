USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[bug_detial_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                  
-- Author:      xie            
-- Create date: 2013-12-06              
-- Description:                   
-- Memo:                    
exec bug_detial_DeleteTag 1                 
*/                  
CREATE PROCEDURE [dbo].[bug_detial_DeleteTag]                   
@id int          
 AS     
              
begin                  
    SET NOCOUNT ON   
      begin tran      
    begin try      
   declare @bugid int =0,@ftype int =0  
   
   
 select @ftype=ftype,@bugid=bugid from bug_detial where id=@id  
   
 update ossapp..bug_detial         
 set deletetag=0  
  where id=@id    
    
 if not exists (select * from bug_detial where bugid=@bugid and id>@id and deletetag=1)  
 begin
  update b set doresult =d1.suggestion
   from buginfo b
    outer apply ( 
     select top 1 suggestion 
      from bug_detial d 
      where b.bugid=d.bugid and d.deletetag=1
      order by d.id desc
   ) d1
   where bugid=@bugid  
 end
 
 commit tran      
   return 1      
    end try      
    begin catch      
  rollback tran      
        return -1      
    end catch  
          
end       
GO
