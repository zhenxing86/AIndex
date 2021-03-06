USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[readcount_Update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[readcount_Update] 
 @uid int,
 @pushid int
 as
 begin
	if exists(select *from ReadCount where userid=@uid and pushid=@pushid)
	begin
		update ReadCount set [count]=[count]+1 where userid=@uid and pushid=@pushid
	end
	else
	begin
		insert into ReadCount(userid,pushid,[count]) values(@uid,@pushid,1)
	end
	if(@@ERROR<>0)
		return -1
	else
		return 1
 end

GO
