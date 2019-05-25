
--应该有个定时器，到了2月1号后，自动将学期切换，并将小朋友信息写入class_all\user_class_all
--没升学期，不初始化新一本成长档案
打开还是上学期的成长档案。


到了2-1号，自动切换学期，初始化新版成长档案，打开新学期成长档案

select* from basicdata..User_Child 
where kid=11061 and account like 'czda[1-9]'

ngbapp..getgrowthbookv2 10878032

select account,* from ngbapp..growthbook g
inner join BasicData..user_child uc
 on g.userid=uc.userid where g.kid=11061 and account like 'czda[1-9]'
 and term='2014-0'

select *
from BasicData..[user] uc
 where usertype=98 and kid =9535

--当前学期
select * from BasicData.dbo.kid_term where kid =9535
select *from basicdata..kindergarten where actiondate<='2014-06-03 19:00'  order by kid desc
select * from basicdata..class where kid=23074
select * from basicdata..class_all where term='2014-1' and cid=32330
select * from basicdata..user_class_all where term='2014-1' and cid =32330
select * from basicdata..user_class where cid >32308
701273
723098
696844

select * from 
 
 delete from BasicData.dbo.kid_term where kid =11061 and term='2014-1'
 update BasicData.dbo.kid_term set iscurrent=0 where kid =11061 and term='2014-0'
--升学期
insert into BasicData..user_class_all(cid,userid,term,actiondate,deletetag)
select 90580,810482,'2014-0',GETDATE(),1

select * from basicdata..user_class_all where term='2014-0'
and userid =810482
select * from basicdata..class_all where term='2014-0' and cid=90580

select * from ngbapp..growthbook --where gbid=10878026
where userid=810482

--成长档案信息
ngbapp..getGrowthbookv2 10855478
select* from ngbapp..growthbook where gbid=10855478

--申请单
select * from gbapp..archives_apply where userid=810475

ngbapp..growthBook

select * delete from BasicData.dbo.kid_term where kid=0


--删除成长档案
select * from ngbapp..growthBook where userid in (810473,810482) and term='2014-0'
delete from ngbapp..growthBook  where gbid in(10878037,
10878026,10855478)

--开放下载
 insert into ngbapp..growthbook_permission(kid,term,bgntime,endtime,candown,deletetag)
select *,kid,'2014-1',bgntime,endtime,0,1 from ngbapp..growthbook_permission 
where kid=11061 and term='2014-0'

update ngbapp..growthbook_permission set endtime='2014-07-09 10:30:00.000'
 where kid=11061 and term='2014-0'
 
--智慧豆查询
select * from BasicData..User_Child where account='czda4'
select*from PayApp..user_pay_account where userid=810475

insert into payApp..user_pay_account (userid,re_amount,re_beancount)
select 810475,50,250

--
select* from basicdata..[User] where kid=4246 and usertype>0--account ='jz1'

select* from LogData..ossapp_addservice_log where describe='关闭'

basicdata..class_all

--确定数据源
旧版 都不改，只要将数据同步好就行了。

 
 ngbapp..GetGrowthBookListV2  已经更新   这个改为在all取。不影响
 
 ngbapp..Init_GrowthBook 还没更新    不影响
 
 ngbapp..[GetHomeBookList]  这个如果更新不知道会不会出现界面错乱(com.zgyey.webapp.homebook/v5/hbbooklist.aspx)  暂不更新
 
 
 select top 1* from ossapp..addservice_status_log
  select top 1* from ossapp..addservice
  
  
 --初始化成长档案问题
 
 
 