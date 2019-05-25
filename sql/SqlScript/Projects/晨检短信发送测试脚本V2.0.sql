sqlagentdb..Move_stu_mc_day_raw_From_Temp
sqlagentdb..init_stu_mc_day

mc_data_GetList mcapp
mc_data_GetList_user

{"cmdid":"UploadStuAllData","serno":"201208240001","vcode":"91642d447d401974a6f09b7a5d804f80","date":"2012-08-24 08:00:00","devid":"001251101","dmcob":[{"stuid":295705,"card":"1401004182","cdate":"2016-04-14 08:05:00","tw":"38.2","zz":"1,2,3","ta":"25.1","toe":"35.6","gunid":"00125110101"},{"stuid":295706,"card":"1308000755","cdate":"2016-04-14 08:00:00","tw":"37.2","zz":"2,3","ta":"25.1","toe":"35.6","gunid":"00125110101"},{"stuid":295707,"card":"1308000756","cdate":"2016-04-14 08:08:00","tw":"37.2","zz":"5","ta":"25.1","toe":"35.6","gunid":"00125110101"}]}

select * from sms_mc_test
select * from push_mc_test
select * from applogs..mc_log where kid=12511 and crtdate>='2016-04-14 16:10'
select * from stu_mc_day_raw_temp where kid=12511 and devid='001251101' and adate>='2016-04-14 16:10'
select * from stu_mc_day_raw where kid=12511 and devid='001251101' and adate>='2016-04-14 16:10'
select * from stu_mc_day where kid=12511 and devid='001251101' and adate>='2016-04-14'
select * from stu_in_out_time where kid=12511 and devid='001251101' and adddate>='2016-04-14 16:10'
select * from stu_mc_day_monitor where kid=12511 and devid='001251101' and adate>='2016-04-14 16:10'

--select * from stu_mc_day_raw where  adate>='2016-04-14'
--delete sms_mc_test
--delete push_mc_test
--delete applogs..mc_log
--delete stu_mc_day_raw where adate>='2016-04-14 16:10'
--delete stu_mc_day where adate>='2016-04-14 16:10'
--delete from stu_in_out_time where adddate>='2016-04-14 16:10'
--delete from stu_mc_day_monitor where adate>='2016-04-14 16:10'

select * from cardinfo where card in('1401004182','1308000755','1308000756')
select * from basicdata..[User_Child] where userid in(295765,295781,295782)

select *
--update d set ftype=0
from stu_mc_day d where kid=12511 and devid='001251101' and adate>='2016-04-14' 
and id in(12215850,12215851,12215834,12215831)

select * from basicdata..[user] where kid =30929 order by regdatetime


/*  [mcapp].[dbo].sms_mc_test 转移到 [mcapp].[dbo].sms_mc，[mcapp].[dbo].push_mc_test 转移到 [mcapp].[dbo].push_mc
declare @t table(guid nvarchar(50),smstype int,recuserid int,recmobile nvarchar(30),sender int,content nvarchar(4000),status int,sendtime datetime,writetime datetime,kid int,cid int,code int)
Delete [mcapp].[dbo].sms_mc_test
  Output deleted.guid,deleted.smstype,deleted.recuserid,deleted.recmobile,deleted.sender,deleted.content,deleted.status,
deleted.sendtime,deleted.writetime,deleted.kid,deleted.cid,deleted.code
  Into @t  

insert into [mcapp].[dbo].sms_mc( guid,smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid,code)
select guid,smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid,code from @t
go

declare @t table(userid int,type nvarchar(50),content nvarchar(1000),writetime datetime,kid int,cid int)
Delete [mcapp].[dbo].push_mc_test
  Output deleted.userid,deleted.type,deleted.content,deleted.writetime,deleted.kid,deleted.cid
  Into @t
  
insert into  [mcapp].[dbo].push_mc( userid,type,content,writetime,kid,cid)
select userid,type,content,writetime,kid,cid from @t
go
*/