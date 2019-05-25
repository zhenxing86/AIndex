  
  
  
  
------------------------------------  
  
------------------------------------  
CREATE PROCEDURE [dbo].[DealErrorSMS]  
  
AS  
  
delete from sms_message_zy_ym where recmobile='18028633611'  
  
delete a from sms_message_ym a  
 where (a.recmobile+a.content) in   
  (select a.recmobile+a.content from sms_message_ym   
    group by recmobile,content having count(*) > 1)  
   and smsid not in (select min(smsid)   
    from sms_message_ym   
     group by recmobile,content having count(*)>1)  
  
INSERT INTO sms..sms_message_zy_ym   
(Guid, recMObile,Status,[content],Sendtime,Kid, Cid,WriteTime,  
  sender,recuserid,smstype)    
 VALUES('', '18028633611',8,'处理重复短信成功',getdate(),18,88,  
   getdate(),0,0,0)    
  
  
  