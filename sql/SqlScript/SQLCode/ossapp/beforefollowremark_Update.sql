USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollowremark_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[beforefollowremark_Update]
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


declare @p int,@kid int

select @kid=kid from beforefollow k where  k.ID=@bf_Id 

if(@remindtime<'2800-1-1')
begin



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


 update kinbaseinfo set bf_lasttime=GETDATE() where kid=@kid


if @@error>0
    begin
       
        rollback transaction
    end
else
    begin
       
        commit transaction
    end







GO
