USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[SMS_ReplayToMsgApp]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[SMS_ReplayToMsgApp]  

 AS 
create table #classuser(cid int ,userid int)
insert into #classuser
select t1.cid,t1.userid from basicdata..user_class t1 left join basicdata..class t2 on t1.cid=t2.cid
left join basicdata..[user] t3 on t1.userid=t3.userid
where t2.kid=17607 and t3.usertype=1 and t3.deletetag=1

INSERT INTO [MsgApp].[dbo].[blog_messagebox]([touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus],[parentid],[deletetag],[deletetagmy])     
select t6.userid,t1.userid,'['+t5.cname+t1.name+'回复短信]:','['+t5.cname+t1.name+'回复短信]:'+t3.content,replytime,0,0,0,1 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid=17607   and t4.userid is not null


delete t3 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid=17607   and t4.userid is not null

drop table #classuser
GO
