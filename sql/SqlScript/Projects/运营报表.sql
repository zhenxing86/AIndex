[payapp].[dbo].[rep_read_getlist] 
于璋 16:13:26
@bgndate date,
@enddate date
于璋 16:13:47
输出：kid	kname	支付方式	总金额

select uc.name,c.userid,c.cardno,a.describe,a.a7
from mcapp..cardinfo c
inner join BasicData..User_Child uc 
 on c.userid=uc.userid
left join ossapp..addservice a 
 on c.userid=a.uid 
 where c.kid=20361 and (a.a7<>806 or a.describe<>'开通')

