USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_SmsMessage_XW_fail_Check]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：短信发送失败检查 
--项目名称：Kmp
--说明：
--时间：2010-06-30 15:48:26
------------------------------------
CREATE PROCEDURE [dbo].[T_SmsMessage_XW_fail_Check]
AS
	BEGIN TRANSACTION
	DECLARE @failcount int
	DECLARE @failcount1 int
	DECLARE @failcount2 int
	DECLARE @czfailcount int
	DECLARE @czfailcount1 int
	DECLARE @czfailcount2 int
	select @failcount1=count(1) from t_smsmessage_xw where status=2 and sendtime between dateadd(day,-1,getdate()) and getdate()
	select @failcount2=count(1) from t_smsmessage_xw where status=7 and sendtime between dateadd(day,-1,getdate()) and getdate()
	set @failcount=@failcount1+@failcount2
	select @czfailcount1=count(1) from CZYCSMS..T_SmsMessage_XW where status=2 and sendtime between dateadd(day,-1,getdate()) and getdate()
	select @czfailcount2=count(1) from CZYCSMS..T_SmsMessage_XW where status=7 and sendtime between dateadd(day,-1,getdate()) and getdate()
	set @czfailcount=@czfailcount1+@czfailcount2
	IF(@failcount>0)
	BEGIN
		insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
		values ('13682238844',0,'短信发送失败,请尽快处理',getdate(),getdate(),18)

		insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
		values ('15920980767',0,'短信发送失败,请尽快处理',getdate(),getdate(),18)
	END
	IF(@czfailcount>0)
	BEGIN
		insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
		values ('13682238844',0,'郴州短信发送失败,请尽快处理',getdate(),getdate(),18)

		insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
		values ('15920980767',0,'郴州短信发送失败,请尽快处理',getdate(),getdate(),18)
	END
	

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (1)
END






GO
