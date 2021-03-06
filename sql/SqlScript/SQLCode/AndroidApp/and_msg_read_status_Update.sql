USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_msg_read_status_Update]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_msg_read_status_Update] 
	@msgid bigint,
	@userid int,
	@msg_code int = null
AS
BEGIN
	SET NOCOUNT ON
	IF (@msg_code = 402 )
	begin
		update basicdata..FriendSMS 
			SET IsRead = 1 
			where ID = @msgid 
				and Touserid = @userid
	end
	else
	begin
	update [AndroidApp].[dbo].[and_msg_detail]
		set readstate=1, readtime = GETDATE()
		where sms_id = @msgid 
			and userid = @userid
	end  
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新状态为已读' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_read_status_Update'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_read_status_Update', @level2type=N'PARAMETER',@level2name=N'@msgid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_read_status_Update', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'402要更新到好友发消息表basicdata..FriendSMS=1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_read_status_Update', @level2type=N'PARAMETER',@level2name=N'@msg_code'
GO
