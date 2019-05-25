
select * from basicdata..[user] where kid=23967 and usertype=1
sqlagentdb
Select b.name From Syscomments a, sysobjects b Where TEXT Like '%push_message_history%' and a.id = b.id

HealthApp
Select b.name From Syscomments a, sysobjects b Where TEXT Like '%subfees_buytime%' and a.id = b.id

 commonfun
 ossapp
dbo.move_push_message
dbo.push_message_pmid
--查某个幼儿园的某个时间范围内的修改[user]表的日志
select l.DoUserID, u.userid,u.account,u.name,u.kid,l.* from BasicData..[user] u left join 
AppLogs.dbo.EditLog l on u.userid=l.KeyCol --and u.kid=20675
 where --l.CrtDate between '2015-10-20' and '2015-10-22' and 
l.DbName='BasicData' and l.TbName='user' and l.KeyCol=2331000
order by l.id

select * from applogs..EditLog where DbName='basicdata' and TbName ='user' and KeyCol =1580548
select account	,kid,name,nickname,regdatetime,enrollmentreason,addtype from basicdata..[user] where account='13431872049'

select * from BasicData..[user] where account in('13978884506','18277193800')


Select * From basicdata.dbo.user_add_new_exec where error=1
Select * From basicdata.dbo.user_add_new_exec where  account='灌茜宜'
Select * From basicdata.dbo.user_add_new_teacher_exec where  account='韦颖菡'
exec [dbo].[user_add_new]   13730,80585,'ll韦颖菡','7C4A8D09CA3762AF61E59520943DC26494F8941B','韦颖菡','2011-07-02 00:00:00.000',2,'13610322203','2015-09-06 00:00:00.000','','','','','','','',536169               
 
--删除无效用户
update u set deletetag=0 
--select count(1)
--select * 
 from BasicData..[user] u
 where regdatetime>='2015-07-01' and deletetag=1 and usertype=0 and addtype<>2 
 and not exists(
  select 1 from BasicData..user_class uc where u.userid=uc.userid)
 and not exists(
  select 1 from BasicData..leave_kindergarten lk where u.userid=lk.userid)
 and not exists (
 select 1 from BasicData..child c where u.userid=c.userid) 

insert into basicdata..[teacher](userid)
select * from basicdata..[user] u
 where u.kid>0 and u.deletetag=1 and u.usertype=1 and not exists(
  select 1 from basicdata..[teacher] t
   where u.userid = t.userid
  )
 
select addtype, *from BasicData..[user] where name like '%u%' order by name