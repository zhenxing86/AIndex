USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_UpdateStatus]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kinfollow_UpdateStatus]
@id int,
@fuid int
 AS 
	update  [kinfollow] set status='已完成',ctime=getdate()
	 WHERE ID=@id and fuid=@fuid

	update [remindlog] set deletetag=0 where rid=@id and uid=@fuid

	declare @kf_id int,@p int
	select @kf_id=kf_id from kinfollow where ID=@id
	
	select @p=count(1) from kinfollow where kf_id=@kf_id and status='待完成'

	if(@p=0)
	begin
		update [remindlog] set result='待结束' where rid=@kf_id and result='待跟进'
	end



GO
