USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[SMS_ReplayToMsgApp]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SMS_ReplayToMsgApp]  

 AS 
create table #classuser(cid int ,userid int)
insert into #classuser
select t1.cid,t1.userid from basicdata..[user] t3
inner join  basicdata..user_class t1 on t3.userid=t1.userid
where t3.kid in(17607,20161,12511) and t3.usertype=1 and t3.deletetag=1

INSERT INTO [MsgApp].[dbo].[blog_messagebox]([touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus],[parentid],[deletetag],[deletetagmy])     
select t6.userid,t1.userid,'['+t5.cname+t1.name+'回复短信]:','['+t5.cname+t1.name+'回复短信]:'+t3.content,replytime,0,0,0,1 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid in(17607,12511,20161)   and t4.userid is not null and t3.status=0

INSERT INTO [MsgApp].[dbo].[blog_messagebox]([touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus],[parentid],[deletetag],[deletetagmy])     
select t6.userid,t1.userid,'['+t5.cname+t1.name+'回复短信]:','['+t5.cname+t1.name+'回复短信]:'+t3.content,replytime,0,0,0,1 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_yx_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid in(20161,12511,17607)   and t4.userid is not null and t3.status=0


update t3 set status=1 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_yx_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid in(20161,12511,17607) and t4.userid is not null


update t3 set status=1 from basicdata..[user] t1 
left join basicdata..user_class t4 on t1.userid=t4.userid
left join basicdata..class t5 on t4.cid=t5.cid
inner join sms_message_up t3  on t1.mobile=t3.fromtel
right join #classuser t6 on t5.cid=t6.cid
where t1.kid in(17607,12511,20161) and t4.userid is not null


drop table #classuser

GO
