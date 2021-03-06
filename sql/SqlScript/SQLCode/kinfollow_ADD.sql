USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[kinfollow_ADD]
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
 @status,
 @information,
 @intime,
 @kf_id,
 @isremind,
 @stime,
 @etime,
 @ctime,
 @deletetag
 	
	)

declare @ID int,@url varchar(300)
set @ID=@@IDENTITY
select @followtype=info from dict where ID=@followtype
set @information='['+@followtype+']'+@information
set @url='/kinfollow/Index?uc=3&kid='+convert(varchar,@kid)
if(@isremind=1)
begin
exec dbo.remindlog_ADD @ID,@url,'待跟进',@information,@etime,@fuid,1
end

if(@fuid<>@uid)
begin
exec dbo.remindlog_ADD @ID,@url,'待跟进',@information,@etime,@uid,1
end
	RETURN @ID




GO
