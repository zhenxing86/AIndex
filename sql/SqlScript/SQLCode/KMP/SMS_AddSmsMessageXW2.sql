USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SMS_AddSmsMessageXW2]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--exec [SMS_AddSmsMessagexw] '13682238844','短信',58,188
--exec sms_getxwsmstask
--作者：along
--更新日期：2006-03-30
--功能：新增短信待发送表

CREATE PROCEDURE [dbo].[SMS_AddSmsMessageXW2] 
	
	@Mobile varchar(200),
	@Content varchar(500),
	@Kid int,
	@Cid int,
	@Sender int,
	@RecUserID int	

AS

declare @Guid varchar(50)
declare @content1 nvarchar(200)
set @content1 = @Content
set @Guid = replace(newid(), '-', '')


--print @content3
insert into T_SmsMessage_XW (Guid, recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values(@Guid, @mobile,0,@content1,getdate(),@kid,@Cid,getdate(),@Sender,@RecUserid)





GO
