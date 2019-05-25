
Select type, title From dbo.[fn_GetOptionTabs](@kid,@role,1) order by orderby    
Select type, title, ico_url ico,url,servtype From kmapp.dbo.[fn_GetHomeMenus](@kid,@role,1) order by orderby 


update OptionsTab set isopen=0 where role=2 and type=4  --默认广场先不开放

--3353,31050,31338,12511,28890,21666,14900,31104,1897,24082

;with cet as(
 select col kid from CommonFun.dbo.f_split('31650',',')t
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,servType,kid)
select type,title,url,role,orderby,isopen,ico_url,servType,c.kid
 from kmapp..HomeMenu h
  cross join cet c 
   where h.kid=28277 and not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid)

;with cet as(
select 1 type,'' title,'' url, 2 role,1 orderby,1 isopen,'' ico_url,0 servType,24082 kid
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,servType,kid)
select type,title,url,role,orderby,isopen,ico_url,servType,c.kid
from cet

select * from kmapp..HomeMenu where kid=28277

Select type, title, ico_url ico,url,servtype From kmapp.dbo.[fn_GetHomeMenus](28277,2,1) order by orderby 
Select type, title From dbo.[fn_GetOptionTabs](28277,2,1) order by orderby  


;with cet as(
 select col kid from CommonFun.dbo.f_split('31446,31590,31577,31591,31423',',')t
)
insert into kmapp..OptionsTab(type,title,url,role,orderby,isopen,kid)
select type,title,url,role,orderby,isopen,c.kid
 from kmapp..OptionsTab h
  cross join cet c 
   where h.kid=28277 and not exists( select 1 from kmapp..OptionsTab hm where hm.kid=c.kid)

select * from kmapp..OptionsTab where kid=31451
select * from kmapp..km_user where kid=28277 and role=2

select * 
--update h set url='http://m.yd.zgyey.com/ReadServer/init?uid={uid}&kid={kid}&client={client}&appver={appver}'
 from kmapp..HomeMenu h where role=2 and title='阅读' and kid=28277
 
--http://m.yd.zgyey.com/ReadServer/init?uid={uid}&kid={kid}&client={client}&appver={appver}  --新版本
--http://m.ats.zgyey.com/ReadServer/Index?uid={uid}&kid={kid}&client={client}&appver={appver}  --老版本


小谢：31451 这个KID。园长，老师，屏蔽【幼儿园】这个tab
家长，园长、老师都开放阅读广场。

select * from Update kmapp..OptionsTab set kid=31573 where kid=31451 
select * from kmapp..OptionsTab where kid=31573 

select * from kmapp..OptionsTab where kid=31451 
select * from kmapp..HomeMenu where kid = 31451
31573  'xzx113'


select * 
-- update o set isopen=0
from kmapp..OptionsTab o where kid=24082 and role=2 and type=3
select * from kmapp..HomeMenu where kid = 24082
select * from kmapp..km_user where account='xzx100'


select * from kmapp..HomeMenu where kid = 23967

--阅读 健康 班级 一日流程  园长

--

;with cet as(
select 1 type,'' title,'' url, 2 role,1 orderby,1 isopen,'' ico_url,0 servType,24082 kid
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,servType,kid)
select type,title,url,role,orderby,isopen,ico_url,servType,c.kid
from cet

;with cet as(
select type,title,url,1 role,orderby,isopen,ico_url,servType,23967 kid from kmapp..HomeMenu where ID in(1,2,3)
union
select 1 type,'一日流程','http://m.oneday.zgyey.com',
1,4,isopen,'http://rewardres.b0.upaiyun.com/2016/2/22/TimeTreeHome/icon_%E6%97%B6%E5%85%89%E6%A0%91%E9%A6%96%E9%A1%B5_%C2%A0%E4%B8%80%E6%97%A5%E6%B5%81%E7%A8%8B.png' ico_url,
20,23967 from kmapp..HomeMenu where ID in(3)
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,servType,kid)
select type,title,url,role,orderby,isopen,ico_url,servType,c.kid
from cet c

select * from kmapp..HomeMenu where kid =23967 
select * from kmapp..ServiceList 
select * from basicdata..[user] where kid =28277 and usertype=0

select *
--UPDATE h set ico_url2='http://rewardres.b0.upaiyun.com/2016/2/22/TimeTreeHome/icon_%E6%97%B6%E5%85%89%E6%A0%91%E9%A6%96%E9%A1%B5_%C2%A0%E7%8F%AD%E7%BA%A7.png'
from kmapp..HomeMenu h
 where kid=23967 and title='一日流程'
 

select *
--UPDATE h set url='http://58.220.10.100:888/BookManager/Index?uid={uid}&kid={kid}&client={client}&appver={appver}'
from kmapp..HomeMenu h
 where kid=23967 and title='阅读' and role in(0,1)



select STUFF(
(select N',' + cast(kid as varchar)  from kmapp..demo_kindergarten for xml path(''))
,1,1,N'')

delete from kmapp..demo_kindergarten  
insert into kmapp..demo_kindergarten(kid)
select col from CommonFun.dbo.f_split(
'24082,20345,534,16055,20989,22030,23108,23273,24675,26039,26985,27629,28422,28548,28829,28890,28934,29096,31062,12511,28277,23967,24082',','
)