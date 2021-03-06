use ossapp
go
/*            
-- Author:      xie      
-- Create date: 2013-11-28            
-- Description:             
-- Memo:              
exec buginfo_Add 1,10,12511,'帼英',6,-1,'2013-11-27 10:00:00','2013-11-28 23:59:59' 
         
*/            
alter PROCEDURE [dbo].[buginfo_Add]            
@bugdes varchar(max),    
@kid int,   
@bugtype int,   
@enddate datetime,       
@douserid int,     
@process int,   
@dodate datetime,  
@userid int,  
@smallbugtype int   
         
 AS             
begin     
    declare @serialno int=1001,@applydate datetime=getdate()
     Begin tran     
 BEGIN TRY    
    select @serialno = max(isnull(serialno,1000))+1   
     from buginfo   
     where applydate>= CONVERT(varchar(10), GETDATE(),120)   
      and applydate<=GETDATE()     
          
        if @serialno is null  
   select @serialno=1001  
          
    insert into buginfo(applydate,bug_des,kid,bug_type,enddate,  
     douserid,process,dodate,userid,update_userid,serialno,small_bug_type)  
     values(@applydate,@bugdes,@kid,@bugtype,@enddate,  
     @douserid,@process,@dodate,@userid,@userid,@serialno,@smallbugtype)  
     
     --加到跟踪资料
     if @kid>0 and @bugtype=3
     begin
        declare @bf_Id int,@serino nvarchar(50),@remark varchar(8000),@remindtype nvarchar(50),@bugid int =0
		set @bugid = IDENT_CURRENT('buginfo')
		set @serino = replace(convert(varchar(10),@applydate,111),'/','')+right(convert(varchar, @serialno),3)
		set @remark = '【'+ @serino+'】'+CommonFun.dbo.ridhtml(@bugdes)  
        --select @remindtype= id from  [dict]  where deletetag=1 and [name]='跟踪类型' and info ='客服反馈' and deletetag=1
        set @remindtype='客服反馈'
        
		select @bf_Id=id from dbo.beforefollow b where b.kid=@kid  
		exec beforefollowremark_ADD 
		  @bf_Id = @bf_Id,  
		  @remark = @remark,  
		  @remindtime = '2900-01-01',  
		  @uid = @userid,  
		  @intime = @applydate,  
		  @deletetag = 1,  
		  @remindtype = @remindtype
		  ,@kid = @kid
		  ,@lv = 0 
		  ,@bugid  =@bugid
		  ,@bugtype =0 
    end
 
	Commit tran                                
 End Try        
 Begin Catch       
  SELECT error_message()  
  Rollback tran        
 end Catch    
 finish:  
	if @@ERROR>0  
	 return -1  
	else return 1   
  
end       
  