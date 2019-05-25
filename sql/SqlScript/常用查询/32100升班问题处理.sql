

select * from basicdata..Class where kid= 32100
--142370

select * from BasicData..leave_kindergarten lk where kid=32100 and outtime>='2018-07-19'
--select * from BasicData..leave_user_class lk where kid=32100 and outtime>='2018-07-19'

select * from BasicData..[user] where userid=2094798  --2094810
select * from BasicData..leave_kindergarten where kid=32100 and userid in (2094798)
select * FROM BasicData..leave_user_class where userid=2094798

insert into BasicData..leave_user_class(cid,userid,actiondatetime)
select 142370,userid,dateadd(hour,-2,GETDATE())
from BasicData..leave_kindergarten lk where kid=32100 and outtime>='2018-07-19'
and not exists(
select * FROM BasicData..leave_user_class luc where lk.userid=luc.userid
)

select * from BasicData..class where kid=32100 and cid in(142370,135068) 
select * from BasicData..class_all where cid=142370   --161477 142370 135068

select * 
--update c set cname='大一班',grade=37
--delete c
from BasicData..class c where kid=32100 and cid in(161476) and id=1404468

select * FROM BasicData..user_class where userid=2134588
select * FROM BasicData..user_class_all where userid=2134588

select * FROM BasicData..user_class_all where cid=135068 and term='2018-0'

-----毕业大一班--------------
select * from BasicData..user_class where cid=142370 
select * FROM BasicData..user_class_all where cid=142370 and term='2018-0'
select * FROM BasicData..user_class_all where cid=142370 and term='2018-1'

select * 
--delete uca
FROM BasicData..user_class_all uca inner join BasicData..[user] u on uca.userid=u.userid
 where u.kid=36520 and term='2018-1' 
  and not exists(
  select * from BasicData..user_class uc where uca.userid=uc.userid and uca.cid=uc.cid
)

insert into user_class_all(cid,userid,term,actiondate,deletetag,[order])
select cid,u.userid,'2018-1',GETDATE(),1,[order] from BasicData..user_class uc inner join BasicData..[user] u on uc.userid=u.userid
 where u.kid=36520 and not exists(
  select * from BasicData..user_class_all uca where uca.userid=uc.userid and uca.cid=uc.cid and term='2018-1'
)


select * 
--update uca set deletetag=1
FROM BasicData..user_class_all uca where cid=135068 and term='2018-0'

select * FROM BasicData..user_class_all where cid=135068 and term='2018-1'

insert into user_class(cid,userid,[order])
select 135068,userid,[order] from BasicData..user_class where cid=142370 

insert into user_class_all(cid,userid,term,actiondate,deletetag,[order])
select cid,userid,'2018-1',GETDATE(),1,[order] from BasicData..user_class where cid=135068

--delete from BasicData..user_class where cid=135068 
delete from BasicData..user_class_all where cid=135068 and term='2018-1'
-----大一班-----------
select * from BasicData..user_class where cid=142370 
select * FROM BasicData..user_class_all where cid=142370 and term='2018-0'
select * FROM BasicData..user_class_all where cid=142370 and term='2018-1'

select * from BasicData..user_class where cid=161477 
select * FROM BasicData..user_class_all where cid=161477 and term='2018-0'
select * FROM BasicData..user_class_all where cid=161477 and term='2018-1'

--delete from BasicData..user_class where cid=142370 
delete from BasicData..user_class where cid=161477 and term='2018-1'



insert into user_class(cid,userid,[order])
select 142370,userid,[order] from BasicData..user_class where cid=161477 order by userid



select *
--update c set deletetag=1
from Class_all c where cid=161477
'13570284153'

--毕业一班 cid=135068  all表修复（）
/*
大一班 cid=142370  error cid=161477

*/

select * 
--delete ca
--update ca set cname='大一班'
from class_all ca where kid=32100 and ID=1404468