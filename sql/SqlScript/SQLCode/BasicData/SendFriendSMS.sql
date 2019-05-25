USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-11  
-- Description: 用于发送好友消息
-- Memo:
*/ 
ALTER PROC SendFriendSMS
	@userid int,
	@touserid int,
	@msgtype int,
	@msgcon nvarchar(500)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO FriendSMS(Userid, Touserid, msgtype, msgcon)    
		VALUES(@userid,@touserid,@msgtype,@msgcon)

	IF EXISTS(SELECT * FROM AndroidApp.dbo.and_userinfo where userid = @touserid and deletetag = 1)	
	BEGIN	
		declare @msgid bigint,@content nvarchar(max),@sender nvarchar(100)  
		set @content='您有新的消息'  
		select @sender = name 
			from BasicData..[user] 
			where userid = @userid  

		insert into AndroidApp..and_msg(title,contents,push_type,msg_type,sent_time,msg_code,sender,send_status,[param])  
			values(@content,@content,1,1,GETDATE(),402,@sender,0,	CONVERT(VARCHAR(10),GETDATE(),120) +'A402a')  
		set @msgid=IDENT_CURRENT('AndroidApp..and_msg')  
		insert into AndroidApp.dbo.and_msg_detail(sms_id, userid, channel_id, device_user_id, tag)  
			select @msgid, userid, channel_id, device_user_id, tag 
				from AndroidApp.dbo.and_userinfo   
				where userid = @touserid 
					and deletetag = 1  
	END
END
GO