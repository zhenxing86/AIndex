use ossapp
go
/*                  
-- Author:      xie            
-- Create date: 2013-12-06              
-- Description:                   
-- Memo:                    
exec bug_detial_Update 527,1,'少废话，赶紧制定一个周密的计划，年前务必搞定。（作为重点）'  

 select rid,applydate,
	     '【'+ replace(convert(varchar(10),applydate,111),'/','')+right(convert(varchar, serialno),3)+'】'  
	    from buginfo
	     where bugid=346

beforefollowremark_add
select * from beforefollowremark where            
*/                  
alter PROCEDURE [dbo].[bug_detial_Update]                   
@id int,             
@douserid int,         
@dosuggestion nvarchar(max)    
 AS                      
begin                  
    SET NOCOUNT ON        
            
    begin tran        
    begin try        
   
   declare @bugid int,@rid int,@kid int=0,@bugtype int=0       
  select @kid=b.kid,@bugid=d.bugid,@rid=d.rid,@bugtype = bug_type  
    from bug_detial d
     inner join buginfo b 
      on d.bugid=b.bugid    
     where id=@id    
         
  update ossapp..bug_detial         
    set suggestion = @dosuggestion  
     where id=@id        
               
  update b         
    set doresult=@dosuggestion,dodate=GETDATE()    
    from  ossapp..buginfo b        
    where bugid=@bugid        
  
  --加到跟踪资料  
     if @kid>0 and @bugtype=3
     begin 
       declare @bf_Id int,@remark varchar(8000),@remindtype nvarchar(50),@applydate datetime
	   select @applydate = applydate,
	     @remark = '【'+ replace(convert(varchar(10),applydate,111),'/','')+right(convert(varchar, serialno),3)+'】'+CommonFun.dbo.ridhtml(@dosuggestion)     
	    from buginfo
	     where bugid=@bugid
	    --select @remindtype= id from  [dict]  where deletetag=1 and [name]='跟踪类型' and info ='客服反馈' and deletetag=1  
	    set @remindtype='客服反馈'  
	          
	    select @bf_Id=id from beforefollow b where b.kid=@kid  
	    
		if isnull(@rid,0)<=0
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
		  else
			exec beforefollowremark_Update  
				@id  =  @rid,  
				@bf_Id = @bf_Id,    
				@remark = @remark,    
				@remindtime = '2900-01-01',    
				@uid = @douserid,    
				@intime = @applydate,    
				@deletetag = 1,    
				@remindtype = @remindtype  
				,@lv = 0  
      
	end  
            
   commit tran        
   return 1        
    end try        
    begin catch        
  rollback tran        
        return -1        
    end catch        
            
end     

  