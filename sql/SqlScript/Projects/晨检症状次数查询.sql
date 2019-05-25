select SUM(case when zz like '%11%' then 1 else 0 end) 家长带回,
SUM(case when zz like '%10%' then 1 else 0 end) 服药提醒, 
SUM(case when zz like '%9%' then 1 else 0 end) 剪指甲, 
SUM(case when zz like '%8%' then 1 else 0 end) 重点观察, 
SUM(case when zz like '%7%' then 1 else 0 end) 红眼病, 
SUM(case when zz like '%6%' then 1 else 0 end) 腹泻, 
SUM(case when zz like '%5%' then 1 else 0 end) 皮疹, 
SUM(case when zz like '%4%' then 1 else 0 end) 流鼻涕, 
SUM(case when zz like '%3%' then 1 else 0 end) 喉咙发炎, 
SUM(case when zz like '%2%' then 1 else 0 end) 咳嗽
, SUM(case when replace(replace(zz,'11','A'),'10','B') like '%1%' then 1 else 0 end) 体温偏高
from mcapp..stu_mc_day d where CheckDate>='2015-01-01'
and not exists(select * from kmapp..demo_kindergarten k 
where d.kid = k.kid)