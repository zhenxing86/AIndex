USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_message_move_201211]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：历史短信移动代理 
--项目名称：sms
--说明：
------------------------------------
create PROCEDURE [dbo].[sms_message_move_201211]
AS
insert into SMS_2012..sms_message_11(guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype)
select guid,recmobile,content,sender,status,recuserid,sendtime,writetime,kid,cid,smstype from [sms_message_curmonth] --where status in(1,3,6,8)

delete [sms_message_curmonth] --where status in(1,3,6,8)
GO
