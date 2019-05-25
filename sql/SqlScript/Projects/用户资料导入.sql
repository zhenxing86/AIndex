use ossapp
go
--资料导入

select u.userid,c.userid,c2.userid,c.kid,c2.kid,* 
 from excel_input_teacher e   
  left join basicdata..[user] u
   on e.account=u.account and u.deletetag=1          
  left join mcapp..cardinfo c             
   on e.card1 = c.[card] 
  left join mcapp..cardinfo c2             
   on e.card2 = c2.[card]   
  where e.kid=20675 and u.usertype=0  and (c.[card] is not null or c2.[card] is not null)  
  and (  
  ((u.userid is null and c.userid>0 and c.kid=20675 and u.usertype=0) or (c.kid is not null and c.kid<>20675)) or 
  ((u.userid is null and c2.userid>0 and c2.kid=20675 and u.usertype=0) or (c2.kid is not null and c2.kid<>20675)) 
  --(( c.userid>0 and c.kid=20675 and u.usertype=0) or c.kid<>20675) or ((c2.userid>0 and c2.kid=20675 and u.usertype=0) or c2.kid<>20675)  
  ) 

select *from mcapp..cardinfo where card in ('1802000002','1802000003','1802000004','1301000001','1301000002','1401000005')
SELECT *from ossapp..excel_input_teacher where kid=20675
SELECT *from ossapp..excel_input_temp where kid=20675 
SELECT *from ossapp..excel_input_teacher where kid=20675
SELECT *from basicdata..[user] where kid=20675 and u.usertype=0 and account in(
'c13951772615'
,'c15851818530'
,'c13770834292'
,'c18761886507'
,'c13951624722'
,'c13912940162'
) and deletetag=1

excel_input_temp
dataimport_Set
dataimport_teacher_GetList
dataimport_update
dataimport_child_GetList


--delete from basicdata..[user] where kid=20675 and u.usertype=0 and regdatetime>='2015-01-14' and deletetag=0
--老师导入

select *
--delete 
from excel_input_teacher where kid=20675 

select *
--update u set deletetag=0
 from basicdata..[user] u where kid=20675 and u.usertype=1 and usertype=1 and regdatetime>='2015-01-14' and deletetag=1

select *
--update u set deletetag=0
 from basicdata..[user] u where kid=20675 and u.usertype=1 and usertype=1 and regdatetime>='2015-01-14' and deletetag=1
 
select *
--delete
 from KWebCMS_Right.dbo.sac_user where createdatetime>='2015-01-14'
select *
--delete 
 from KWebCMS..site_user where siteid=20675 and createdatetime>='2015-01-14'
select *
--delete 
 from KWebCMS_Right.dbo.sac_user_role r
  inner join basicdata..[user] u 
   on r.[user_id]=u.userid where u.kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete t
 from basicdata..[teacher] t
  inner join basicdata..[user] u 
   on t.userid=u.userid where kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete uc
 from basicdata..[user_class] uc
  inner join basicdata..[user] u 
   on uc.userid=u.userid where kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete uca
 from basicdata..user_class_all uca
  inner join basicdata..[user] u 
   on uca.userid=u.userid and term='2014-1' where kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete ub
 from basicdata..user_bloguser ub
  inner join basicdata..[user] u 
   on ub.userid=u.userid where kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete r
 from reportapp..[rep_child_add_delete] r
  inner join basicdata..[user] u 
   on r.userid=u.userid where u.kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
select *
--delete t
 from basicdata..user_add_temp t
 inner join basicdata..[user] u 
   on t.userid=u.userid where u.kid=20675 and u.usertype=1 and u.regdatetime>='2015-01-14'
 
 
 
 --卡号

 
 select * from mcapp..cardinfo_log where kid= 20675 and udate>='2015-01-14'
 

--学生导入
select *
--delete 
from excel_input_teacher where kid=20675 and usertype=0

select *
--update u set deletetag=0
 from basicdata..[user] u where kid=20675 and u.usertype=0 and u.usertype=0 and regdatetime>='2015-01-14' and deletetag=1
 
select *
--delete c
from basicdata..[child] c
inner join basicdata..[user] u 
   on c.userid=u.userid where kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'

select *
--delete uc
 from basicdata..[user_class] uc
  inner join basicdata..[user] u 
   on uc.userid=u.userid where kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'
select *
--delete uca
 from basicdata..user_class_all uca
  inner join basicdata..[user] u 
   on uca.userid=u.userid and term='2014-1' where kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'
select *
--delete ub
 from basicdata..user_bloguser ub
  inner join basicdata..[user] u 
   on ub.userid=u.userid where kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'
select *
--delete r
 from reportapp..[rep_child_add_delete] r
  inner join basicdata..[user] u 
   on r.userid=u.userid where u.kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'
select *
--delete t
 from basicdata..user_add_temp t
 inner join basicdata..[user] u 
   on t.userid=u.userid where u.kid=20675 and u.usertype=0 and u.regdatetime>='2015-01-14'









