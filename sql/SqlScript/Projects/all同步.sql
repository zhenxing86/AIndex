--select *from basicdata..[user] where account='18720006084'

--1 清空basicdata..class_all/user_class_all表数据(term in ('2014-0','2014-1') )
delete from class_all where kid=20298 and term in('2014-0','2014-1')
         ----[[delete from basicdata..user_class_all where kid=20298 and term in('2014-0','2014-1')
delete from uca
 from user_class_all uca
  inner join class c on uca.cid=c.cid where kid=20298 and term in('2014-0','2014-1')

--2 用basicdata1407..class/user_class的数据term='2014-0'插入到basicdata..class_all/user_class_all  
--(附注：要将4246幼儿的class_all数据的isgraduate同步下)
insert into class_all(cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
 select b.cid, b.kid, b.cname, b.grade, b.[order], deletetag,b.sname,b.actiondate,b.iscurrent,subno,'2014-0',0
  from basicdata1407..class b 
  where kid=20298
  
  '15185563556'
 update ca set isgraduate=isgraduate
  from class_all ca
   inner join basicdata1407..class_all c on ca.cid=c.cid and ca.term=c.term 
    and c.deletetag=1 and ca.deletetag=1
    and ca.term='2014-0' and c.kid=4246
    
insert into user_class_all(cid,userid,term,actiondate,deletetag)
 select uc.cid,userid,'2014-0',GETDATE(),1
  from basicdata1407..user_class uc
   inner join class c on uc.cid=c.cid where kid=20298 and deletetag=1
   
--3 将basicdata1407..leave_user_class数据term='2014-0'插入到basicdata..user_class_all 
insert into user_class_all(cid,userid,term,actiondate,deletetag)
 select luc.cid,userid,'2014-0',actiondatetime,1
  from basicdata1407..leave_user_class luc
   inner join class c on luc.cid=c.cid where kid=20298
  

--4 将basicdata..class/user_class表数据term='2014-1'插入到basicdata..user_class_all
insert into class_all(cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
 select b.cid, b.kid, b.cname, b.grade, b.[order], deletetag,b.sname,b.actiondate,b.iscurrent,subno,'2014-1',0
  from class b 
  where kid=20298
    
insert into user_class_all(cid,userid,term,actiondate,deletetag)
 select uc.cid,userid,'2014-1',GETDATE(),1
  from user_class uc
   inner join class c on uc.cid=c.cid where kid=20298



 


