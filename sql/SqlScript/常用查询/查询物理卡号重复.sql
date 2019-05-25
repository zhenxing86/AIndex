use mcapp
go

select * from mcapp..cardinfo where '00'+gate_card=card and kid=24082
select * from mcapp..cardinfo where gate_card=card and kid=24082
select * from mcapp..cardinfo_log where gate_card='1243431552'

select * from  AppLogs..editlog where dbname='mcapp' and tbname='cardinfo' and KeyCol='1243431552' order by id
select * from ossapp..users where id=359

select * 
--delete
 from mcapp..cardinfo where kid=37696 order by id

--mcapp..gate_card_repeat_GetList @kid=36955
select COUNT(1),gate_card --,min(crtdate) [min-crtdate],MAX(crtdate) [max-crtdate],MIN(kid) [min-kid],MAX(kid) [max-kid]
 from mcapp..cardinfo 
 where gate_card is not null and kid=24082
  group by gate_card
 having COUNT(1)>1 --and MIN(kid)=MAX(kid)
 order by id
 --order by MAX(crtdate)