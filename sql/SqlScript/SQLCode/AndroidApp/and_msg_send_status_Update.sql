USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_msg_send_status_Update]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_msg_send_status_Update] 
@msgid bigint,
@send_status int
AS

update
  [AndroidApp].[dbo].[and_msg]
  set [send_status]=@send_status
	where ID=@msgid
  
select @msgid


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改推送状态（执行推送后会使用）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_send_status_Update'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_send_status_Update', @level2type=N'PARAMETER',@level2name=N'@msgid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息状态（0待发送，1已发送，2发送失败）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_send_status_Update', @level2type=N'PARAMETER',@level2name=N'@send_status'
GO
