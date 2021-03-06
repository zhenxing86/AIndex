USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_SmsMessage_XW_Check]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：短信发送情况检查 
--项目名称：Kmp
--说明：
--时间：2010-06-30 15:48:26
------------------------------------
CREATE PROCEDURE [dbo].[T_SmsMessage_XW_Check]
AS
	BEGIN TRANSACTION
	DECLARE @failcount int
	DECLARE @successcount int
	DECLARE @unsendcount int
	DECLARE @failcount1 int
	DECLARE @successcount1 int
	DECLARE @unsendcount1 int
	select @failcount=count(1) from t_smsmessage_xw where status=2 and sendtime between dateadd(day,-1,getdate()) and getdate()
	select @failcount1=count(1) from t_smsmessage_xw where status=7 and sendtime between dateadd(day,-1,getdate()) and getdate()

	select @successcount=count(1) from t_smsmessage_xw where status=1  and sendtime between dateadd(day,-1,getdate()) and getdate()
	select @successcount1=count(1) from t_smsmessage_xw where status=6  and sendtime between dateadd(day,-1,getdate()) and getdate()

	select @unsendcount=count(1) from t_smsmessage_xw_temp where status=0  and sendtime between dateadd(day,-1,getdate()) and getdate()
	select @unsendcount1=count(1) from t_smsmessage_xw_temp where status=5  and sendtime between dateadd(day,-1,getdate()) and getdate()


	insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
	values ('13682238844',0,'本次检查短信:失败数:玄武'+cast(@failcount as varchar)+'电信'+cast(@failcount1 as varchar)+';成功数:玄武'+cast(@successcount as varchar)+'电信'+cast(@successcount1 as varchar)+';待发送数:玄武'+cast(@unsendcount as varchar)+'电信'+cast(@unsendcount1 as varchar),getdate(),getdate(),18)

	insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
	values ('13808828988',0,'本次检查短信:失败数:玄武'+cast(@failcount as varchar)+'电信'+cast(@failcount1 as varchar)+';成功数: 玄武'+cast(@successcount as varchar)+'电信'+cast(@successcount1 as varchar)+';待发送数:玄武'+cast(@unsendcount as varchar)+'电信:'+cast(@unsendcount1 as varchar),getdate(),getdate(),18)

	insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
	values ('13560233701',0,'本次检查短信:失败数:玄武'+cast(@failcount as varchar)+'电信'+cast(@failcount1 as varchar)+';成功数: 玄武'+cast(@successcount as varchar)+'电信'+cast(@successcount1 as varchar)+';待发送数:玄武'+cast(@unsendcount as varchar)+'电信:'+cast(@unsendcount1 as varchar),getdate(),getdate(),18)

	insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
	values ('15989086897',0,'本次检查短信:失败数:玄武'+cast(@failcount as varchar)+'电信'+cast(@failcount1 as varchar)+';成功数: 玄武'+cast(@successcount as varchar)+'电信'+cast(@successcount1 as varchar)+';待发送数:玄武'+cast(@unsendcount as varchar)+'电信:'+cast(@unsendcount1 as varchar),getdate(),getdate(),18)

	insert into T_SmsMessage_XW ( recMObile,Status,content,Sendtime,WriteTime,Kid)
	values ('13660048898',0,'本次检查短信:失败数:玄武'+cast(@failcount as varchar)+'电信'+cast(@failcount1 as varchar)+';成功数: 玄武'+cast(@successcount as varchar)+'电信'+cast(@successcount1 as varchar)+';待发送数:玄武'+cast(@unsendcount as varchar)+'电信:'+cast(@unsendcount1 as varchar),getdate(),getdate(),18)


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
