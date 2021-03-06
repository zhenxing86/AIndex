USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollowremark_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--Add
--select * from dbo.remindlog
--rid=@ID,url='/beforefollowremark/Index?uc=2&kfid=@bf_Id','跟踪提醒',@remark,@remindtime,@uid,1
------------------------------------
CREATE PROCEDURE [dbo].[beforefollowremark_ADD]
  @bf_Id int,
 @remark varchar(5000),
 @remindtime datetime,
 @uid int,
 @intime datetime,
 @deletetag int,
 @remindtype varchar(100)
 ,@kid int
 ,@lv int
 AS 

  declare @ID int
begin transaction


	INSERT INTO [beforefollowremark](
  [bf_Id],
 [remark],
 [remindtime],
 [uid],
 [intime],
 [deletetag],
remindtype,lv
 
	)VALUES(
	
  @bf_Id,
 @remark,
 @remindtime,
 @uid,
 @intime,
 @deletetag,
 @remindtype,@lv	
	)

  
	set @ID=@@IDENTITY

if(@remindtime<'2800-1-1')
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
values(@ID,@url,'待'+@remindtype,'['+@remindtype+'提醒]'+@remark,@remindtime,@uid,1,'新增',getdate(),@bf_Id,@kid,@lv)

end




 update kinbaseinfo set bf_lasttime=GETDATE() where kid=@kid


if @@error>0
    begin
       
        rollback transaction
RETURN 0
    end
else
    begin
       
        commit transaction
RETURN @ID
    end



GO
