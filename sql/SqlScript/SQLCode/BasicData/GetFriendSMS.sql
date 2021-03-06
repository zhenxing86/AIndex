USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetFriendSMS]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-11  
-- Description: 用于读取好友消息
-- Memo:exec GetFriendSMS 653615, 653612
--select * from [user] where account in('jz1','jz2') 
*/ 
CREATE PROC [dbo].[GetFriendSMS]
	@userid int,
	@touserid int
AS
BEGIN
	SET NOCOUNT ON
	SELECT	u.name, u.Userid, u.Headpic, u.HeadpicUpdate, 
					fs.msgtype, fs.msgcon, fs.CrtDate				
		FROM FriendSMS fs
			inner join [user] u 
				on fs.userid = u.userid
		where fs.userid = @userid
			and fs.touserid = @touserid
			and fs.IsRead = 0
		ORDER BY fs.CrtDate
	IF @@ROWCOUNT > 0
	update FriendSMS set IsRead = 1
		where userid = @userid
			and touserid = @touserid
			and IsRead = 0
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机端获取好友消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMS', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接收人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendSMS', @level2type=N'PARAMETER',@level2name=N'@touserid'
GO
