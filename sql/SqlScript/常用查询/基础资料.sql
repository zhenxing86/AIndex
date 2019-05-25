use BasicData
go



--33228]华中师范大学附属天门幼儿园  振兴，麻烦一下，导出这家园本学期的新生哦，

-----------------【3】从2017/2月份开始注册的新生--------------------------
 select uc.kid,uc.cname,uc.account,uc.mobile,uc.name,u.regdatetime from basicdata..user_child uc
 inner join basicdata..[user] u
  on uc.userid=u.userid
   where u.kid=33228 and u.regdatetime>='2017-02-01'


[32833]肇庆市鼎湖区机关幼儿园  [33152]肇庆鼎湖区沙浦镇中心幼儿园 振兴，麻烦帮忙将这两家园本学期的新生导出一下，谢谢哦

--导出离园用户  --[34114]瑶湖保育院瑶湖部，另外能否导出这个园上学期中途离园的人，本学期新来的人呢？
 select k.kid,c.cname,u.account,u.mobile,u.name,u.regdatetime,k.outtime
  from basicdata..[user] u
  inner join basicdata..leave_kindergarten k on u.userid=k.userid 
  inner join basicdata..leave_user_class uc on uc.userid=u.userid
  inner join basicdata..class c on c.cid = uc.cid
   where k.kid=33152 and u.regdatetime>='2016-09-01' --and u.regdatetime<='2017-02-01'
    and u.usertype=0
    
    
--[33849]广州市黄埔育才幼儿园,导一下这个园本学期新添加的老师
 select u.kid,t.title,u.account,u.mobile,u.name,u.regdatetime
  from basicdata..[user] u
 inner join BasicData..teacher t on t.userid=u.userid
   where u.kid=33152 and u.regdatetime>='2017-02-01' and usertype>0

--查询调班记录
select * from kmapp.dbo.user_class_update_history where userid=2158189
select * from BasicData..user_class_all where userid=2158189
select * from AppLogs.dbo.EditLog where DbName='BasicData' and TbName='user_class' and KeyCol2=2158189

------------------------------------用户排序不了的bug--------------------------------------
  ;with data as(
  select uc.*,ROW_NUMBER() over(partition by uc.cid order by uc.ucid) raws
   from user_class uc
   inner join [user] u on u.userid=uc.userid
   inner join Class c on c.cid=uc.cid where c.kid=5213 and u.usertype=0 and uc.[order] is null  --cid=155823  -- userid=2371824
  )
  update d set [order]=raws
  from data d
  
  
  --用户排序不了的bug
  ;with data as(
  select uc.*,ROW_NUMBER() over(partition by uc.cid order by uc.ucid) raws
   from user_class uc
   inner join [user] u on u.userid=uc.userid
   inner join Class c on c.cid=uc.cid where c.kid=5213 and u.usertype=0 and uc.cid=122530  -- userid=2371824
  )
  update d set [order]=raws
  from data d
  
use GBApp
go
--create table class_tmp(cname nvarchar(50),username nvarchar(50),orderby int)
--truncate table class_tmp
--drop table class_tmp

;with data as(
	select ct.username, uc.*,c.cname,ROW_NUMBER() over(partition by uc.cid order by uc.ucid) raws,ct.orderby
	from gbapp..class_tmp ct
	left join basicdata..[user] u on ct.username=u.name and u.deletetag=1 and u.usertype=0 and u.kid=5213
	left join basicdata..Class c on c.cname=ct.cname and c.deletetag=1 and c.cid=143151
	left join basicdata..user_class uc on u.userid = uc.userid and c.cid=uc.cid  
)
update d set [order]=orderby
from data d

select * from BasicData..class where kid=5213 and cname='小三班'
update class_tmp set cname='小三班'

;with data as(
  select uc.*,ROW_NUMBER() over(partition by uc.cid order by uc.[order] desc) raws
   from user_class uc
   inner join [user] u on u.userid=uc.userid
   inner join Class c on c.cid=uc.cid where c.kid=5213 and u.usertype=0 
)
update d set [order]=raws
 from data d
 
 
select * from BasicData..class where kid=5213 and cname='小三班'
update class_tmp set cname='小三班'

-------------------------------------------------------------------------------------------------------
  

select * from ossapp..dict where name='跟踪类型' order by ID
insert into ossapp..dict(id,name,info,deletetag)
values(2419,'跟踪类型','阅读结算',1)

--增加oss帐号
select * from ossapp..users where account='lcy'
insert into ossapp..users(account,password,usertype,roleid,bid,name,regdatetime,seruid,deletetag,jxsid)
 values('lcy','7C4A8D09CA3762AF61E59520943DC26494F8941B',0,1,0,'李朝洋',GETDATE(),0,1,0)
