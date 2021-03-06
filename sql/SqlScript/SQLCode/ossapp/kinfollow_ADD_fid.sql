USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_ADD_fid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[kinfollow_ADD_fid]
  @kid int,
 @followtype varchar(100),
 @fuid int,
 @uid int,
 @status varchar(20),
 @information varchar(3000),
 @intime datetime,
 @kf_id int,
 @isremind int,
 @stime datetime,
 @etime datetime,
 @ctime datetime,
 @deletetag int
 
 AS 


begin transaction
declare @errorsum int

update [kinfollow] set [status]='跟进中',ctime='1900/1/1' where ID=@kf_id

set @errorsum=@errorsum+@@error

INSERT INTO [kinfollow](
  [kid],
 [followtype],
 [fuid],
 [uid],
 [status],
 [information],
 [intime],
 [kf_id],
 [isremind],
 [stime],
 [etime],
 [ctime],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @followtype,
 @fuid,
 @uid,
 '待完成',
 @information,
 @intime,
 @kf_id,
 @isremind,
 @stime,
 @etime,
 @ctime,
 @deletetag
 	
	)
set @errorsum=@errorsum+@@error


  if @errorsum>0
    begin
    
        rollback transaction
    end
else
    begin
       
        commit transaction
    end



    declare @ID int,@url varchar(300),@fid int
	set @ID=@@IDENTITY
	select @followtype=info from dict where ID=@followtype
	set @information='['+@followtype+']'+@information
	set @url='/kinfollow/Index?uc=3&kid='+convert(varchar,@kid)

	if(@isremind=1)
	begin
		exec dbo.remindlog_ADD @ID,@url,'待跟进',@information,@etime,@fuid,1
	end
	
	declare @xkf_id int
	select @xkf_id=kf_id from kinfollow where ID=@id
	update [remindlog] set deletetag=1,result='待跟进' where rid=@xkf_id and result='待结束' and deletetag=0


	RETURN @ID




GO
