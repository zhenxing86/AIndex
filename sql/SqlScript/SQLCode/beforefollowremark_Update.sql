use ossapp
go
/*  
exec beforefollowremark_Update  
		@id  =  50213,  
		@bf_Id = 38590,    
		@remark = '【20150115001】少废话，赶紧制定一个周密的计划，年前务必搞定。（作为重点）',    
		@remindtime = '2941-01-01',    
		@uid = 1,    
		@intime = '2015-01-15 19:13:39.963',    
		@deletetag = 1,    
		@remindtype = '客服反馈'  
		,@lv = 0  

SELECT  g.[ID]    ,[bf_Id]    ,g.[remark]    ,[remindtime]      
,g.[uid]    ,g.[intime]  ,g.deletetag,u.[name],g.remindtype,r.ID,g.lv  
  FROM [beforefollowremark] g  
inner join users u on u.ID=g.uid  
left join remindlog r on r.rid=g.ID and r.deletetag=1 and result='待'+remindtype  
  where g.deletetag=1  and bf_Id=38590 order by g.[ID] desc  
  
*/
  
alter PROCEDURE [dbo].[beforefollowremark_Update]  
 @ID int,  
 @bf_Id int,  
 @remark varchar(5000),  
 @remindtime datetime,  
 @uid int,  
 @intime datetime,  
 @deletetag int,  
 @remindtype varchar(100),  
 @lv int  
 AS   
  
  
  
begin transaction  
 declare @new_remindtype varchar(100)  
 set @new_remindtype=@remindtype  
 select @remindtype=remindtype from [beforefollowremark]  WHERE ID=@ID   
 
 UPDATE [beforefollowremark] SET   
  [bf_Id] = @bf_Id,  
 [remark] = @remark,  
 [remindtime] = @remindtime,  
 [uid] = @uid,  
 remindtype=@new_remindtype,  
 [deletetag] = @deletetag,  
 lv=@lv  
   WHERE ID=@ID   
  
	if(@remindtime<'2800-1-1')  
	begin  
		declare @p int,@kid int
		select @p=count(1) from  remindlog where rid=@ID and result='待'+@remindtype  
		if(@p>0)  
		begin  
			update remindlog set result='待'+@new_remindtype, info='['+@new_remindtype+'提醒]'+@remark,intime=@remindtime,deletetag=1,lv=@lv  
			where rid=@ID and result='待'+@remindtype  
			  
			insert into remindlog_bak(rid,attention,result,info,intime,uid,deletetag,dotype,dotime,lv)  
			values(@ID,'','待'+@remindtype,'['+@remindtype+'提醒]'+@remark,@remindtime,@uid,1,'更新',getdate(),@lv)  
		  
		end  
		else  
		begin  
			select @kid=kid from beforefollow k where  k.ID=@bf_Id   
			declare @url varchar(100)  
			set @url='/beforefollowremark/Index_Main?uc=10&kid='++convert(varchar,@kid)  
			if(@kid=0)  
			begin  
				set @url='/beforefollowremark/Index?uc=2&kfid='+convert(varchar,@bf_Id)  
			end  
			  
			insert into remindlog(rid,attention,result,info,intime,uid,deletetag,bfid,kid,lv)  
			values(@ID,@url,'待'+@remindtype,'['+@remindtype+'提醒]'+@remark,@remindtime,@uid,1,@bf_Id,@kid,@lv)  
			  
			insert into remindlog_bak(rid,attention,result,info,intime,uid,deletetag,dotype,dotime,bfid,kid,lv)  
			values(@ID,@url,'待'+@remindtype,'['+@remindtype+'提醒]'+@remark,@remindtime,@uid,1,'修改',getdate(),@bf_Id,@kid,@lv)  
			  
		end  
	end  
	else  
	begin  
	  
		update remindlog set deletetag=0  
		where rid=@ID and result='待'+@remindtype  
	  
	end  
  
if @@error>0  
begin  
     print 'error'
    rollback transaction  
end  
else  
begin  
     print 'succeed'
    commit transaction  
end  
  
  
  
  
  