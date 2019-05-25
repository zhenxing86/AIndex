USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[Att_Sms_To_SmsTable]    Script Date: 06/15/2013 17:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from sms..sms_message_curmonth where kid=13715
--exec [Att_Sms_To_SmsTable] 13715
CREATE PROCEDURE [dbo].[Att_Sms_To_SmsTable] 
@kid int
AS
BEGIN

insert into sms..sms_message 
([Guid],recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
select  replace(newid(), '-', '') Guid,t2.mobile,0,t2.name+'小朋友，在'+convert(varchar(16),t1.checktime,20)+'刷卡入园',getdate() Sendtime,
t1.kid,0,getdate() WriteTime
					,0 senderuserid,t1.userid,99 smstype
					from [att_sms] t1 left join basicdata..user_baseinfo t2 on t1.userid=t2.userid
 where t1.kid=@kid and 
t1.issendsms=0 and len(t2.mobile)=11


update [att_sms] set issendsms=1 where kid=@kid and issendsms=0

end
GO
