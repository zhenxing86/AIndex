USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByUidSend]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  [MsgTeacher_GetListByUidSend] '0','1',123,'2013-01-01',1
CREATE PROCEDURE [dbo].[MsgTeacher_GetListByUidSend]
@useridstr varchar(max),
@content varchar(1000),
@guserid int,
@sendtime datetime,
@istime int
as 

--SMS..sms_message
--smstype=99
--recuserid接收者userid
--recmobile接收者手机号
--sender发送者userid（group_user表中的id）
--content发送的内容
--status=0 待发送
--sendtime 定时发送的时间不是定时时即写当前时间
--writetime当前系统时间
--kid接收者kid
--cid接收者所在班级的id

set @useridstr='0'+@useridstr
declare @pcount int

if(@istime=1)
begin
insert into SMS..sms_message(smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid)
exec('select 99,r.userid,r.mobile,'+@guserid+',replace('''+@content+''',''%teaname%'',r.[name]),0,'''+@sendtime+'''
,getdate(),n.kid,0 cid
from BasicData..kindergarten n
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
where len(r.mobile)=11 and r.userid in ('+@useridstr +')')
end
if(@istime=0)
begin

insert into SMS..sms_message_temp(smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid)
exec('select 99,r.userid,r.mobile,'+@guserid+',replace('''+@content+''',''%teaname%'',r.[name]),0,'''+@sendtime+'''
,getdate(),n.kid,0 cid
from BasicData..kindergarten n
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
where len(r.mobile)=11 and r.userid in ('+@useridstr +')')

end

set @pcount=@@ROWCOUNT 

update dbo.group_baseinfo set smscount=smscount-@pcount where gid=@guserid

GO
