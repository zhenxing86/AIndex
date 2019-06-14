USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Send_Add]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SMS_Send_Add]
@content varchar(300),
@guid varchar(500),
@mobile varchar(50),
@uid int,
@kid int
 AS 

insert into sms..sms_message (guid,smstype,recuserid,recmobile,sender,[content],status,sendtime,writetime,kid,cid)
values (@guid,50,0,@mobile,@uid,@content,0,getdate(),getdate(),@kid,0)



GO
