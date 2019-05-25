


---------------时光树家长端关闭成长档案的入口，把他换成微网站的入口------------- 

[km_getHomeMenus]                                            
@uid =1099745,                                            
@role =2,                                                  
@appver = '222',                                             
@client = 0,                                         
@kid = 26872 

select * from basicdata..[user] where kid=26872 and usertype=0
select * from basicdata..[user] where kid=20675 and usertype=0

--Select type, title, ico_url ico,url From dbo.[fn_GetHomeMenus](@kid,@role,1) order by orderby  

select * from kmapp..HomeMenu where kid=26872   --如果没有记录，则使用 kid=-1的记录复制一份到 这个园。然后修改对应的菜单
--insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,26872,module_id from HomeMenu where kid=-1 and isopen=1 

select * from kmapp..HomeMenu where kid=20675 and role=2 and title='微网站'
select * 
--update h set type=1,title='微网站',url='',orderby=4,ico_url='http://kmapp.zgyey.com/Content/homemenu/health.png',servtype=10,ico_url2='http://cdn.rs.oss.zgyey.com/HomeMenu/microWebSite.png',module_id=8
from HomeMenu h where kid=26872 and role=2 and isopen=1 and ID = 2868 



select *
--update h set title='成长评估',servtype=23,url='http://m.yzbb.zgyey.com/home/healthservice?uid={uid}&hxuid={hxuid}&token=&kid={kid}&client={client}&appver={appver}&role={role}' 
from kmapp..HomeMenu h where kid =-5 and title='微网站'


select top 10* 
from BasicData..[user] u
 where u.kid>10000 and u.deletetag=1 and u.usertype=0 and not exists(select 1 from kmapp..HomeMenu h where u.kid = h.kid
 )
 

select * 
--update h set isopen=1,title='幼儿园'
from kmapp..OptionsTab h where kid= 24082 and title='服务' and role<2


select * 
--update h set kid= -1
from kmapp..HomeMenu h  where kid= 24082  


--默认全国开放首页菜单
select * 
--update h set kid= -1
from kmapp..HomeMenu h  where kid= -1 and isopen=1 

--家长默认全国开放广场
select * 
--update h set isopen= 1
from kmapp..OptionsTab h  where kid= 0 and role=2 and title='广场'

select * 
--update h set isopen= 0
from kmapp..OptionsTab h  where kid= 32971 and title='广场' and role=2 
'http://m.czpg.zgyey.com/?uid={uid}&token=&role={role}&kid={kid}&hxuid={hxuid}&client={client}&appver={appver}&key={appver}'


--关闭时光树首页菜单取默认值,勾选后,时光树首页菜单只取本园定制的菜单,即使为空,也不取默认值
insert into BlogApp..permissionsetting (ptype,kid,group_no)
values(129,12511,1)
dbo.hc_grow
healthapp.dbo.hc_grow

select * from BlogApp..permission where ptype=129
select * from BlogApp..permissionsetting where ptype=129

select *  from kmapp..HomeMenu where isopen=1 and title='一日流程'
select * from kmapp..HomeMenu where ico_url2 is null and isopen=1
select kid from kmapp..HomeMenu 
select * from kmapp..ServiceList 

select *from basicdata..[user] where kid =32026 and usertype=0
select top 2* from kmapp..km_user where kid=32026 and role=2
kmapp..km_login 'chhlls','7C4A8D09CA3762AF61E59520943DC26494F8941B', '34253ydfg675hr56'   
kmapp..km_loginV2 'xzx113','7C4A8D09CA3762AF61E59520943DC26494F8941B', '34253ydfg675hr56'   
kmapp..[km_loginV2] '13969003217', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '34253ydfg675hr56'    

select * from kmapp..HomeMenu where kid = 23967 and role=2
select * from kmapp..HomeMenu where kid = 24082 and role=2
select * from kmapp..HomeMenu where kid = 12511 --and role=2


select * from kmapp..HomeMenu where kid = 28277 and role=2

32099,1897

23292  --阅读



select * 
--update h set isopen=1
 from kmapp..OptionsTab h
where role=2 and title='广场' and isopen=0 and kid in(
13942,25274
)


select * from kmapp..ServiceList 







--title\url\ico_url\ico_url2\servtype\type
declare 
@title nvarchar(500)='借阅公约',
@url nvarchar(500)='http://m.readservice.zgyey.com/BorrowManager/JYFW?uid={uid}&kid={kid}&client={client}&appver={appver}&role={role}',
@ico_url nvarchar(500)='http://kmapp.zgyey.com/Content/homemenu/ats.png',
@ico_url2 nvarchar(500)='',
@servtype int=21
update h set title=@title,url=@url,ico_url=@ico_url,ico_url2=@ico_url2,servtype=@servtype,type=1
from kmapp..HomeMenu h 
 where kid= -2 and role=1 and title='班级'
 
 select * from kmapp..HomeMenu h  where kid =-2 and role=2 
'http://m.ats.zgyey.com/ReadServer/Index?uid={uid}&kid={kid}&client={client}&appver={appver}&role={role}&head=0'

select *
--update h set title='本月书单' 
from kmapp..HomeMenu h 
 where kid= -2 and role =1 and title='班级'
--------------------------------END-------------------------------------

--1	家长普通版
--2	家长借阅版
--3	园长阅读综合版
--4	老师阅读综合版
--5	园长借阅专用版
--6	老师借阅专用版

--家长普通版 ( 阅读\健康\班级\成长)
select * from kmapp..HomeMenu h  where kid =0 and role=2  and module_id=1

--园长/老师阅读综合版(阅读\健康\班级\微网站)   --开了阅读系统的需要将老师、家长都开。
select * from kmapp..HomeMenu h  where kid =-3 and role in(0,1) and module_id=3

--家长借阅版 (借阅服务\本月书单\本园藏书\借阅公约)   --【借阅服务\本月书单地址还有问题。】
select * from kmapp..HomeMenu h  where kid =-2 and role=2  and module_id=2
--园长/老师借阅专用版(图书管理\本月书单\借阅管理\借阅服务)
select * from kmapp..HomeMenu h  where kid =-4 and role in(0,1) and module_id=5

select * from kmapp..HomeMenu h  where kid =24082 and role=2
select * from kmapp..HomeMenu h  where kid =35179 and role=2

--[35179]广州市萝岗区中大附属外语幼儿园   这家园 ，麻烦帮我把时光树配置成纯阅读版哦 

------------------三套模板---------------------'jnyyey'
select * from kmapp..HomeMenu h  where kid =33685 order by role,orderby

32099,1897



23292  --阅读
-- 1、家长普通版，园长老师不开通（场景：没有开通借阅服务或者没有定制菜单）  ptype=119   kid = 12511
select * from kmapp..HomeMenu h  where kid =0 and role=2

declare @kids nvarchar(4000)='32099'
--select *
delete h 
 from kmapp..HomeMenu h inner join CommonFun.dbo.f_split(@kids,',')t on t.col=h.kid 
;with cet as(
 select col kid from CommonFun.dbo.f_split(@kids,',')t
),
data as(
select *,1 gg from kmapp..HomeMenu h  where kid =0 and role=2
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,c.kid,d.gg
 from data d 
  cross join cet c 
   where not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid) 
go

-- 1.1、家长普通版V2 (微网站\成长评估\阅读\班级)，园长老师不开通  kid = 20675,31970
select * from kmapp..HomeMenu h  where kid =31970 and role=2

declare @kids nvarchar(4000)='31970'
--select *
delete h 
 from kmapp..HomeMenu h inner join CommonFun.dbo.f_split(@kids,',')t on t.col=h.kid 
;with cet as(
 select col kid from CommonFun.dbo.f_split(@kids,',')t
),
data as(
select *,7 gg from kmapp..HomeMenu h  where kid =-5 and role=2
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,c.kid,d.gg
 from data d 
  cross join cet c 
   where not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid) 
go

--  2、家长普通版，园长老师开通综合版（场景：开通借阅服务或者没有定制菜单） kid = 23967,28277,  
--31721,31691,31643,31642,31633,31630,9449,32103,32104,32105,32106,32107,32108,32110,32111,32112,32113,31727,31729,31758
--27146,31640

-----------------------家长普通版、园长老师综合版28277---------------------------
select * from kmapp..HomeMenu h  where kid =0 and role=2
select * from kmapp..HomeMenu h  where kid =-3 and role in(0,1)
select * from kmapp..HomeMenu h  where kid =23292 and role=2

31339,31340,31341,31342,31343,31344,31345,31346,31347,31348,31349,31360,31355,31356,31357,31358,31359,31429,31431,29447


declare @kids nvarchar(4000)='28277'
select *
--delete h 
 from kmapp..HomeMenu h inner join CommonFun.dbo.f_split(@kids,',')t on t.col=h.kid 
;with cet as(
 select col kid from CommonFun.dbo.f_split(@kids,',')t
),
data as(
select *,1 gg from kmapp..HomeMenu h  where kid =0 and role=2
union all select *,3 from kmapp..HomeMenu h  where kid =-3 and role in(0,1)
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,c.kid,d.gg
 from data d 
  cross join cet c 
   where not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid) 



------- 2.2、园长老师综合版V2 (微网站\成长评估\阅读\班级)，园长老师不开通  kid = 20675,31970---------------

家长普通版V3	包含 阅读、家园联系、班级、微网站 8
园长综合版V2	包含 阅读、家园联系、班级、微网站 9

--23292华夏博雅，时光树APP四大模块改成阅读、家园联系、班级、微网站，家长，老师，园长端都开放

select * from kmapp..HomeMenu h  where kid =23292 and role=2

declare @kids nvarchar(4000)='23292'
--select *
delete h 
 from kmapp..HomeMenu h inner join CommonFun.dbo.f_split(@kids,',')t on t.col=h.kid 
;with cet as(
 select col kid from CommonFun.dbo.f_split(@kids,',')t
),
data as(
select *,8 gg from kmapp..HomeMenu h  where kid =-7 and role=2
union all select *,9 from kmapp..HomeMenu h  where kid =-7 and role in(0,1)
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,c.kid,d.gg
 from data d 
  cross join cet c 
   where not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid) 
go


--3、家长借阅版，园长/老师借阅专用版（场景：定制只开阅读）         kid = 24082
select * from kmapp..HomeMenu h  where kid =-2 and role=2 
select * from kmapp..HomeMenu h  where kid =-4 and role in(0,1)
select * from kmapp..HomeMenu h  where kid =35182 and role=2

[35182]广州市黄埔区诺亚舟雅筑幼儿园  这家园 ，麻烦帮我把时光树配置成纯阅读版哦 

declare @kids nvarchar(4000)='31062'
--select *
delete h 
 from kmapp..HomeMenu h inner join CommonFun.dbo.f_split(@kids,',')t on t.col=h.kid 
;with cet as(
 select col kid from CommonFun.dbo.f_split(@kids,',')t
),
data as(
select *,2 gg from kmapp..HomeMenu h  where kid =-2 and role=2 
union all select *,5 from kmapp..HomeMenu h  where kid =-4 and role in(0,1)
)
insert into kmapp..HomeMenu(type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,kid,module_id)
select type,title,url,role,orderby,isopen,ico_url,ico_url2,servType,c.kid,d.gg
 from data d 
  cross join cet c 
   where not exists( select 1 from kmapp..HomeMenu hm where hm.kid=c.kid) 
go  
------------------------------------------------------------------------
[33685]广州市黄埔区天鹿幼儿园，帮我把这家的园时光树改成纯阅读版的。
把老师身份幼儿园栏里的“幼儿园文档、我的文档、绘本教程”这三个留下，其他都不要
把家长身份幼儿园这栏直接删掉

km_getServices 2147457, 1, 1 ,33685,0,1.082         

select * from kmapp..[km_user] where kid=33685 and role=1
-----------------------------开放广场-------------------------
select distinct kid from kmapp..OptionsTab  where kid in(35179)
select * from kmapp..OptionsTab where kid in(35182) and isopen=1
;with cet as(
 select col kid from CommonFun.dbo.f_split('35182',',')t
)
insert into kmapp..OptionsTab(type,title,url,role,orderby,isopen,kid)
select type,title,url,role,orderby,isopen,c.kid
 from kmapp..OptionsTab h
  cross join cet c 
   where h.kid=28277 and not exists( select 1 from kmapp..OptionsTab hm where hm.kid=c.kid)

select *
--update o set isopen=0 
from kmapp..OptionsTab o where kid =33685 and role=2 and isopen=1 and type=2
-------------------------开通权限 ------------------------
--开通借阅系统 119、开通成长评估123、成长评估收费园 132.老师开放数字图书 65.

insert into BlogApp..permissionsetting(ptype,kid,group_no)
select 65 ptype,col kid, 0
from CommonFun.dbo.f_split('31721,31691,31643,31642,31633,31630,9449,32103,32104,32105,32106,32107,32108,32110,32111,32112,32113,31727,31729,31758'
,',') k 
where not exists(select 1 from BlogApp..permissionsetting p where p.kid=k.col and ptype=65)
go
-------------------------------修改图标----------------------------------
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/curMonthBooklist.png'
from kmapp..HomeMenu h  where role in (0,1) and title='本月书单' and kid = -4
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/borrowManager.png'
from kmapp..HomeMenu h  where role in (0,1) and title='借阅管理' and kid = -4
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/kindergartenBooks.png'
from kmapp..HomeMenu h  where role in (0,1) and title='本园藏书' and kid = -4
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/borrowConvention.png'
from kmapp..HomeMenu h  where role in (0,1) and title='借阅公约' and kid = -4
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/bookManager.png'
from kmapp..HomeMenu h  where role in (0,1) and title='图书管理' and kid = -4

update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/read.png'
from kmapp..HomeMenu h  where title='阅读' --and kid = 23967
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/health.png'
from kmapp..HomeMenu h  where title='健康' --and kid = 23967
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/class.png'
from kmapp..HomeMenu h  where title='班级' --and kid = 23967
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/growth.png'
from kmapp..HomeMenu h  where title='成长' --and kid = 23967

update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/microWebSite.png'
from kmapp..HomeMenu h  where title='微网站' --and kid = 23967

update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/borrowServiceDirector.png'
from kmapp..HomeMenu h  where role in(0,1) and title='借阅服务' --and kid = 23967
update h set ico_url2='http://rewardres.b0.upaiyun.com/HomeMenu/borrowService.png'
from kmapp..HomeMenu h  where role =2 and title='借阅服务' --and kid = 23967


--------------------首页菜单及借阅公约定制统计-------------------
;with cet as(
select distinct kid,1 readVer from kmapp..HomeMenu where title ='借阅服务' and kid>0
union all
select distinct kid,0 readVer from kmapp..HomeMenu where title ='阅读' and kid>0
),data as(
select substring(convention, PATINDEX('%tx">借阅服务费%',convention)+9,7) 借阅服务费,
substring(convention, PATINDEX('%借阅时间最长不超过%',convention)+9,2) 借阅时间,
* 
from atsapp..set_config_model where kid>0
)
select case when readVer=1 then '借阅版' else '综合版' end 模板类型,c.kid,
ISNULL(k.kname,'——') 幼儿园名称,k.regdatetime 注册时间, 
case when k.infofrom='代理' then ag.name else k.infofrom end 所属分公司, 
case when pe.readService>0 then '开通' else '——' end 是否开通借阅服务,
case when pe.payOnline>0 then '开通' else '——' end 是否开通在线支付,
ISNULL(d.借阅服务费,'——')借阅服务费,
ISNULL(d.借阅时间,'——')借阅时间,bu.借阅证号数量,bo.幼儿总人数,ad.开通借阅的人数,isnull(bil.图书库存,0)图书库存,bo.借阅次数
from cet c 
 outer apply (
 select sum( case when p.ptype=119 then 1 else 0 end) readService,
        sum( case when p.ptype=109 then 1 else 0 end) payOnline
  from BlogApp..permissionsetting p where p.kid = c.kid and p.ptype in (109,119)
 ) pe
 outer apply (select SUM(cnt) 图书库存 from ReadApp..bm_book_inventory_log bi where bi.kid=c.kid) bil
 outer apply (select sum(case when u.usertype=0 then 1 else 0 end) 幼儿总人数,count(o.userid) 借阅次数 from BasicData..[user] u
   left join ReadApp..bm_borrow_record_object o
       on o.userid = u.userid
       where u.kid=c.kid and u.deletetag=1) bo
 outer apply (select COUNT(1) 借阅证号数量 from readapp..bm_userinfo b where b.kid=c.kid) bu
 outer apply (select COUNT(1) 开通借阅的人数 from ossapp..addservice a where a10>0 and a.kid=c.kid and a.describe='开通' and a.deletetag=1)ad
 inner join ossapp..[kinbaseinfo] k on c.kid = k.kid
 left join ossapp..[agentbase] ag on ag.ID = k.abid
 left join data d on c.kid=d.kid

所属分公司（市场），幼儿园注册时间，是否开通在线支付、幼儿总人数、开通借阅的人数、图书库存、借阅次数

users_GetListTag_Bid ossapp

select * from readapp..bm_userinfo
select * from ossapp..addservice where a10>0 and [uid]=@userid and describe='开通' and deletetag=1

select * from ossapp..[kinbaseinfo] k 
 inner join ossapp..[agentbase] ag on ag.ID = k.abid
 where k.kid =31928
 
 --select * from ossapp..users where ID= 4

--市场人员	4

--------------------------------------------------------------------------------

--默认家长都开通 【家长普通版( 阅读\健康\班级\成长)】，园长老师都不开放。

--只有开通了借阅系统的幼儿园，园长老师开放 【园长/老师阅读综合版(阅读\健康\班级\微网站)】
有119，但是只开通借阅的，
有119，但没有开通借阅的，要家长、园长和老师要先补上
有119，有家长开通借阅的，园长和老师要先补上。

--家长借阅版 (借阅服务\本月书单\本园藏书\借阅公约)
--园长/老师借阅专用版(图书管理\本月书单\借阅管理\借阅服务)

--如果没有开通借阅系统,切换不了'我的书单\借阅服务'







