USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_register_sms_ADD]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：短信发送
--项目名称：classhomepage
--说明：
--时间：2009-4-15 22:54:31
------------------------------------
CREATE PROCEDURE [dbo].[kindergarten_register_sms_ADD]
@content varchar(500)
 AS 
	insert into sms..sms_message (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
	values('', '13682238844',0,@content,getdate(),18,88,getdate(),0,0,0)

	insert into sms..sms_message (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
	values('', '13808828988',0,@content,getdate(),18,88,getdate(),0,0,0)
	
IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END









GO
