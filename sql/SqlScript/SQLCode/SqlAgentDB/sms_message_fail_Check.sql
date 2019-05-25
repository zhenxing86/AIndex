  
  
  
  
  
  
  
--select * from sms_message where status=2  
  
------------------------------------  
--用途：短信发送失败检查代理   
--项目名称：sms  
--说明：  
------------------------------------  
create PROCEDURE [dbo].[sms_message_fail_Check]  
AS  
 BEGIN TRANSACTION  
 DECLARE @failcount int  
 DECLARE @failcount1 int  
 DECLARE @failcount2 int,@failcount3 int  
 DECLARE @czfailcount int  
 DECLARE @czfailcount1 int  
 DECLARE @czfailcount2 int  
 select @failcount1=count(1) from sms..sms_message where status=2 and sendtime between dateadd(day,-1,getdate()) and getdate()  
 select @failcount2=count(1) from sms..sms_message_ym where status=7 and sendtime between dateadd(day,-1,getdate()) and getdate()  
 select @failcount3=count(1) from sms..sms_message_zy_ym where status=10 and sendtime between dateadd(day,-1,getdate()) and getdate()  
 set @failcount=@failcount1+@failcount2+@failcount3  
 --select @czfailcount1=count(1) from CZYCSMS..T_SmsMessage_XW where status=2 and sendtime between dateadd(day,-1,getdate()) and getdate()  
 --select @czfailcount2=count(1) from CZYCSMS..T_SmsMessage_XW where status=7 and sendtime between dateadd(day,-1,getdate()) and getdate()  
 --set @czfailcount=@czfailcount1+@czfailcount2  
 IF(@failcount>0)  
 BEGIN  
--  insert into sms_message ( recMObile,Status,content,Sendtime,WriteTime,Kid)  
--  values ('13682238844',0,'短信发送失败,请尽快处理',getdate(),getdate(),18)  
  
  insert into sms..sms_message_zy_ym ( recMObile,Status,content,Sendtime,WriteTime,Kid)  
  values ('18028633611',8,'短信发送失败,请尽快处理[幼儿园]',getdate(),getdate(),18)  
  
  update sms..sms_message set status=0 where status=2 and len(recmobile)=11  
  --update sms_message set status=0 where status=7 and len(recmobile)=11  
  
  update sms..sms_message set status=21 where status=2 and len(rtrim(ltrim(content)))=0  
    
  update sms..sms_message_zy_ym set status=8 where status=10 and len(recmobile)=11  
  
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
  
  
  
  
  
  
  
  