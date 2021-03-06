USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_ym_deal]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
------------------------------------  
--用途：ymsms_deal  
--项目名称：sms  
--说明：  
------------------------------------  
CREATE PROCEDURE [dbo].[sms_ym_deal]  
AS  
  
Create Table #TempSms(smsid Bigint)  
  
Insert Into #TempSms  
  Select smsid from sms_message_ym where status=6  
  
insert into [sms_message_curmonth]  
(guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype,taskid,code)  
select guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype,taskid,code   
from sms_message_ym where smsid In (Select smsid from #TempSms)  
  
delete sms_message_ym where smsid In (Select smsid from #TempSms)  
  
truncate table #TempSms  
  
Insert Into #TempSms  
  Select smsid FROM [SMS].[dbo].[sms_message] where status=1  
  
INSERT INTO [SMS].[dbo].[sms_message_curmonth]([guid],[smstype],[recuserid],[recmobile],[sender],[content],[status],[sendtime],[writetime],[kid],[cid],[code],taskid)  
     SELECT [guid],[smstype],[recuserid],[recmobile],[sender],[content],[status],[sendtime],[writetime],[kid],[cid],[code],taskid  
  FROM [SMS].[dbo].[sms_message] where smsid In (Select smsid from #TempSms)  
  
delete [sms_message] where smsid In (Select smsid from #TempSms)  
  
truncate table #TempSms  
  
Insert Into #TempSms  
  Select smsid FROM sms_message_zy_ym where status=9  
  
insert into [sms_message_curmonth](guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype,taskid,code)  
 select guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype ,taskid,code
 from sms_message_zy_ym where smsid In (Select smsid from #TempSms)  
  
delete sms_message_zy_ym where smsid In (Select smsid from #TempSms)  
   
truncate table #TempSms  
  
Insert Into #TempSms  
  Select smsid FROM sms_message_yx where status=11  
  
insert into [sms_message_yx_temp](guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype,taskid,code)  
 select guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype,taskid,code   
   from sms_message_yx where smsid In (Select smsid from #TempSms)  
  
delete sms_message_yx where smsid In (Select smsid from #TempSms)  
   
Drop table #TempSms  
  
  
GO
