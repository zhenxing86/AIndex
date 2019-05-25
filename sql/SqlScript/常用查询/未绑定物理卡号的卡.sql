--'13808828988jz'

select * 
--update g set weight= case when growid=8824 then 16 when growid=9616 then 18 when growid=10807 then 20 else  15 end
from [healthapp].[dbo].[hc_grow] g where userid=1458946 order by indate

select * 
--update g set weight= case when growid=8824 then 16 when growid=9616 then 18 when growid=10807 then 20 else  15 end
from [healthapp].[dbo].[hc_grow] g where userid=2293235 order by indate 



select * from mcapp..cardinfo where kid=18289 and gate_card is not null
select * from mcapp..cardinfo c
 inner join BasicData..User_Child uc on c.userid=uc.userid and uc.grade=38
 where c.kid=18289 and c.gate_card is not null and c.userid>0
 
 select * from mcapp..cardinfo c
 inner join BasicData..User_Child uc on c.userid=uc.userid and uc.grade<>38
 where c.kid=18289 and c.gate_card is null and c.userid>0
 
 where kid=18289 and userid>0 and gate_card is not null
select * from mcapp..cardinfo c where kid=18289 and userid>0 and gate_card is null
select * from mcapp..cardinfo where kid=18289 and userid>0 and gate_card is null

select * from mcapp..cardinfo where kid=18289 and usest=0 and gate_card is null