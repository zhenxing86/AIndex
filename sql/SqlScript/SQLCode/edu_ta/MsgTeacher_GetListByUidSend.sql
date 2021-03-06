USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByUidSend]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






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
insert into sms_message_taedu(smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid)
exec('select distinct 99,[uid],u_mobile,'+@guserid+',replace('''+@content+''',''%teaname%'',uname),0,'''+@sendtime+'''
,getdate(),r.kid,0 cid
from rep_kininfo r
 where len(u_mobile)=11 and usertype=1 and [uid] in ('+@useridstr +')')
end
if(@istime=0)
begin

insert into sms_message_temp_taedu(smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid)
exec('select distinct 99,[uid],u_mobile,'+@guserid+',replace('''+@content+''',''%teaname%'',uname),0,'''+@sendtime+'''
,getdate(),kid,0 cid
from rep_kininfo r
where len(u_mobile)=11 and usertype=1 and [uid] in ('+@useridstr +')')

end

set @pcount=@@ROWCOUNT 
 
update dbo.group_user set smscount=smscount-@pcount where userid=@guserid






GO
