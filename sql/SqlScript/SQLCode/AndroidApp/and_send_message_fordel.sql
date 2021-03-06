USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_send_message_fordel]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_send_message_fordel]     
@userid int    
,@channel_id varchar(100)=''    
,@device_user_id varchar(100)=''    
,@contents varchar(2000)    
AS    
    
begin tran    
begin TRY    
declare @msgid bigint    
    
    
insert into and_msg(title,contents,push_type,msg_type,sent_time,msg_code,sender,send_status,[param])    
values('',@contents,1,0,GETDATE(),401,'中国幼儿园门户',0,CONVERT(varchar(10),getdate(),120)+'A401a')     
    
set @msgid=IDENT_CURRENT('and_msg')     
    
    
 --重复登录的提示在这里    
 insert into dbo.and_msg_detail(sms_id,userid,channel_id,device_user_id,tag)    
 select @msgid,@userid,channel_id,device_user_id,tag from and_userinfo     
  where userid=@userid     
   and channel_id<>@channel_id     
   and device_user_id<>@device_user_id    
   and deletetag=1    
      
 update dbo.and_userinfo set deletetag=1     
   where userid=@userid    
   and channel_id=@channel_id     
   and device_user_id=@device_user_id     
       
 update dbo.and_userinfo set deletetag= 2 
   where userid=@userid     
   and channel_id<>@channel_id     
   and device_user_id<>@device_user_id    
   and deletetag=1    
     
     
    
COMMIT TRAN     
END TRY     
BEGIN CATCH     
ROLLBACK TRAN     
SELECT ERROR_NUMBER() AS ErrorNumber,    
ERROR_SEVERITY() AS ErrorSeverity,    
ERROR_STATE() as ErrorState,    
ERROR_MESSAGE() as ErrorMessage;     
END CATCH    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录后，发送消息，踢掉其他人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_send_message_fordel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机标识（苹果手机=0）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_send_message_fordel', @level2type=N'PARAMETER',@level2name=N'@channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_send_message_fordel', @level2type=N'PARAMETER',@level2name=N'@device_user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提示内容（推送的消息的内容）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_send_message_fordel', @level2type=N'PARAMETER',@level2name=N'@contents'
GO
