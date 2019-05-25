use mcapp
go

--[mc_sms_man_setting]  trg_sms_man_kid
--sms_man_kid_GetList
--SendDoctorWeixinContent


select  * from mcapp..sms_man_kid where kid=37085


--²éÑ¯ÐÞ¸Ä¼ÇÂ¼
;with data as(
select k.ID,[userid], [kid], [cid], [roletype],DoUserID,CrtDate,'inserted' dotype from AppLogs..EditLog e 
 inner join mcapp..sms_man_kid k on e.KeyCol=k.ID 
  where DbName='mcapp' and TbName='sms_man_kid'  and k.kid=37085
union all
select Col1,Col2,Col3,Col4,Col5,DoUserID,CrtDate,'deleted'
from AppLogs.dbo.DelLog d
  where DbName='mcapp' and TbName='sms_man_kid'  and col3=37085
  --order by CrtDate
)
select * from data where userid= 2443389 order by CrtDate 

