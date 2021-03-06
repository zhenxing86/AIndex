USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[FriendList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 用于返回好友列表
-- Memo:select * from [user] where kid=20244
select * from blogapp..permissionsetting where kid=20244
exec FriendList 795231
*/ 
CREATE PROC [dbo].[FriendList]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	declare @kid int
	declare @utype int
	declare @ptype int
	select @kid = kid,@utype=usertype from [user] where userid=@userid
	select @ptype=ptype from blogapp..permissionsetting where kid=@kid and ptype=35
	if(@utype=0 and @ptype=35)		
	begin
		SELECT	gf.name, gf.utype, gf.userid, gf.headpic, 
					gf.headpicupdate, ISNULL(fs.cnt,0)SmsCnt 
		FROM Basicdata.[dbo].GetFriendList(@userid) gf
			left join basicdata..FriendSMS_v fs 
				on gf.userid = fs.userid
				and fs.touserid = @userid where gf.utype<>'好友'
		order by gf.usertype desc
	end 
	else
	begin
	SELECT	gf.name, gf.utype, gf.userid, gf.headpic, 
					gf.headpicupdate, ISNULL(fs.cnt,0)SmsCnt 
		FROM Basicdata.[dbo].GetFriendList(@userid) gf
			left join basicdata..FriendSMS_v fs 
				on gf.userid = fs.userid
				and fs.touserid = @userid-- where gf.utype='好友'
		order by gf.usertype desc
	end
END
GO
