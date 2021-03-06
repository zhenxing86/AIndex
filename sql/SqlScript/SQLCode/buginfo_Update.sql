use ossapp
go
/*                
-- Author:      xie          
-- Create date: 2013-11-28                
-- Description:                 
-- Memo:                  
exec buginfo_Update 1,10,12511,'帼英',6,-1,'2013-11-27 10:00:00','2013-11-28 23:59:59'     
  
exec [buginfo_Update]      
@bugid =346,              
@bugdes ='test ssss',        
@kid =12511,       
@bugtype =3,       
@enddate ='2015-01-15',           
@douserid =134,         
@userid =134,    
@smallbugtype =2,    
@reasonlevel =0   
           
*/                
alter PROCEDURE [dbo].[buginfo_Update]      
@bugid int,              
@bugdes varchar(max),        
@kid int,       
@bugtype int,       
@enddate datetime,           
@douserid int,         
@userid int,    
@smallbugtype int=0,    
@reasonlevel int=0    
 AS                 
begin                
    update buginfo    
     set bug_des=@bugdes,kid=@kid,bug_type=@bugtype,    
     enddate=@enddate,douserid=@douserid,update_userid=@userid    
     ,small_bug_type = @smallbugtype,reason_level = @reasonlevel    
    where bugid=@bugid    
      
    --加到跟踪资料  
     if @kid>0 and @bugtype=3 
     begin  
        declare @rid int ,@bf_Id int,@serino nvarchar(50),@remark varchar(8000),@remindtype nvarchar(50),@applydate datetime,@serialno int=1001  
		  select @rid=rid,@applydate=applydate,@serino = replace(convert(varchar(10),applydate,111),'/','')+right(convert(varchar, serialno),3)  
		   from buginfo where bugid=@bugid  
		  set @remark = '【'+ @serino +'】'+ CommonFun.dbo.ridhtml(@bugdes)  
				--select @remindtype= id from  [dict]  where deletetag=1 and [name]='跟踪类型' and info ='客服反馈' and deletetag=1  
				set @remindtype='客服反馈'  
		  select @bf_Id=id from dbo.beforefollow b where b.kid=@kid    
		  
		  if isnull(@rid,0)<=0
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
		  else
			exec beforefollowremark_Update  
				@id  =  @rid,  
				@bf_Id = @bf_Id,    
				@remark = @remark,    
				@remindtime = '2900-01-01',    
				@uid = @userid,    
				@intime = @applydate,    
				@deletetag = 1,    
				@remindtype = @remindtype  
				,@lv = 0   
	end  
      
if @@ERROR>0      
 return -1      
else return 1       
      
end 