select * from basicdata..kid_term where term='2018-0'




/*
-----------------------------------------
--1、幼儿园在不该升班的时候进行了升班操作(在幼儿资料那里直接将小朋友转移到新的班级)。
--导致幼儿园之前学期的数据都变成修改后的信息，而学期还是以前学期的。
--也就相当于调班。

一、假如现在还是没到升班时间（距离9-1还有2个月以上），那么可以直接将班级调回去即可。
二、假如现在已经到了升班时间（距离9-1小于2个月，或者超过9-1），那么需要找技术协助。
1） 直接将班级调回去；将已经离园的用户返园回去。
2） 技术需要将class_all和user_class_all表的数据 将前后两个学期的数据对调
*/

--将前后两个学期的数据对调

--user_class_all 对调
select * from basicdata..user_class_all uca
 inner join BasicData..class c on uca.cid=c.cid where kid= 20581 and uca.term='2016-0' and uca.deletetag=1

update uca set term='AAAA' from basicdata..user_class_all uca
 inner join BasicData..class c on uca.cid=c.cid where c.kid= 20581 and uca.term='2016-0' and uca.deletetag=1
update uca set term='2016-0' from basicdata..user_class_all uca
 inner join BasicData..class c on uca.cid=c.cid where c.kid= 20581 and uca.term='2016-1' and uca.deletetag=1
update uca set term='2016-1' from basicdata..user_class_all uca
 inner join BasicData..class c on uca.cid=c.cid where c.kid= 20581 and uca.term='AAAA' and uca.deletetag=1


--class_all 对调
select * from basicdata..class_all where kid= 20581 and term='2016-0'

update ca set term='AAAA' from basicdata..class_all ca where kid= 20581 and term='2016-0' and deletetag=1
update ca set term='2016-0' from basicdata..class_all ca where kid= 20581 and term='2016-1' and deletetag=1
update ca set term='2016-1' from basicdata..class_all ca where kid= 20581 and term='AAAA' and deletetag=1



--------------------------------------------------
select * from basicdata..user_class_all uca
 inner join BasicData..class_all ca
  on uca.cid=ca.cid and ca.deletetag=1 and uca.deletetag=1 and uca.term=ca.term where kid= 20581 and ca.term='2016-1'
  order by ca.cid

select * from basicdata..user_class uc
 inner join BasicData..class c
  on uc.cid=c.cid and c.deletetag=1 where kid= 20581 
  order by c.cid





---------------------------最好的方法，是拿旧数据库还原。-------------------------------------------
select * from basicdata..user_class uc
 inner join BasicData..class c
  on uc.cid=c.cid and c.deletetag=1
   where kid= 20581 

select * 
from BasicData..class
 where kid=20581 and deletetag=1
 
select * 
from BasicData..class_all
 where kid=20581 and deletetag=1 and term='2016-0'

select top 0 * into gbapp..class_all from basicdata..class_all
select top 0 * into gbapp..user_class_all from basicdata..user_class_all

 
select * 
--delete
 from basicdata..class_all
where kid=20581 and term='2016-1'

insert into BasicData..class_all(cid,kid,cname,grade,[order],deletetag,sname,actiondate,iscurrent,subno,term,isgraduate)
select cid,kid,cname,grade,[order],deletetag,sname,actiondate,iscurrent,subno,term,isgraduate
from basicdata..class





--从备份数据取数据 插入到 gbapp..user_class_all
="INSERT into user_class_all(cid,userid,term,[order],deletetag) values('"&A2&"','"&B2&"','2016-0','"&D2&"',1)"

--删除原有数据
select uc.*
--delete uc
 from BasicData..[user_class_all] uc
  inner join BasicData..[user] u
   on uc.userid=u.userid and term='2016-0' 
  where u.kid=18023
  
--从gbapp..user_class_all同步到 basicdata..user_class_all
insert into BasicData..[user_class_all](cid,userid,term,deletetag,[order])
select cid,u.userid,'2016-0',1,uc.[order]
 from gbapp..[user_class_all] uc
  inner join BasicData..[user] u
   on uc.userid=u.userid --and term='2016-0' 
  where u.kid=18023


select * 
--delete uc
 from basicdata..user_class_all uc
   inner join BasicData..class c
  on uc.cid=c.cid and c.deletetag=1
where kid=20581 and term='2016-1'

--insert into BasicData..user_class_all(cid,userid,term,actiondate,deletetag,[order])
select uc.cid,userid,'2016-1',actiondate,deletetag,uc.[order]
from basicdata..user_class uc
 inner join BasicData..class c
  on uc.cid=c.cid and c.deletetag=1
  where kid=20581 


