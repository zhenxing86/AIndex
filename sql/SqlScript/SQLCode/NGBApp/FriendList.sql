USE Basicdata
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 用于返回好友列表
-- Memo:
exec FriendList 295765
*/ 
CREATE PROC FriendList
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	SELECT	gf.name, gf.utype, gf.userid, gf.headpic, 
					gf.headpicupdate, ISNULL(fs.cnt,0)SmsCnt 
		FROM Basicdata.[dbo].GetFriendList(@userid) gf
			left join basicdata..FriendSMS_v fs 
				on gf.userid = fs.userid
				and fs.touserid = @userid 
		order by gf.usertype desc
END
GO