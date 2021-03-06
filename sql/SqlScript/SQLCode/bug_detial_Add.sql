use ossapp
go
/*              
-- Author:      xie        
-- Create date: 2013-11-28              
-- Description:               
-- Memo:                
exec bug_detial_Add 1             
*/              
alter PROCEDURE [dbo].[bug_detial_Add]               
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
		declare @id int =0
		insert into bug_detial(bugid,suggestion,douserid,dodate,ftype)     
		 select @bugid,@suggestion,@douserid,GETDATE(),  
		  (case when userid=@douserid then 0 when douserid=@douserid then 1 else 2 end ) ftype  
		  from buginfo    
		   where bugid=@bugid  
	   
		set @id=IDENT_CURRENT('bug_detial')      
		update b     
		 set doresult=@suggestion,  
		  dodate = GETDATE(),    
		  process = @process,  
		  reason_level=@reasonlevel   
		 from  buginfo b    
		  where bugid=@bugid    
	    
		 declare @bf_Id int,@kid int,@remark varchar(8000),@remindtype nvarchar(50),@applydate datetime,@bugtype int=0 
		  select @applydate = applydate,@kid=kid,@bugtype=bug_type,
		  @remark = '【'+ replace(convert(varchar(10),applydate,111),'/','')+right(convert(varchar, serialno),3)+'】'+CommonFun.dbo.ridhtml(@suggestion)   
		   from buginfo
			where bugid=@bugid
	  
		 --加到跟踪资料  
		 if @kid>0 and @bugtype=3 
		 begin 
			  --select @remindtype= id from  [dict]  where deletetag=1 and [name]='跟踪类型' and info ='客服反馈' and deletetag=1  
			  set @remindtype='客服反馈'  
			          
			  select @bf_Id=id from beforefollow b where b.kid=@kid    
			  exec beforefollowremark_ADD   
				@bf_Id = @bf_Id,    
				@remark = @remark,    
				@remindtime = '2900-01-01',    
				@uid = @douserid,    
				@intime = @applydate,    
				@deletetag = 1,    
				@remindtype = @remindtype  
				,@kid = @kid  
				,@lv = 0   
				,@bugid  =@id  
				,@bugtype =1  
		end  
	    commit tran    
	    return 1    
    end try    
    begin catch    
		rollback tran    
        return -1    
    end catch    
        
end   
  