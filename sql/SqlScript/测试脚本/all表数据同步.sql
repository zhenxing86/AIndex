 
 select COUNT(1) from BasicData..class where deletetag=1
 select COUNT(1) from BasicData..class_all where term='2014-1' and deletetag=1

 --class_all同步
  declare @kid int= 0,@term nvarchar(6)='2014-1' 
   ;With Data as (    
 select c.cid, c.kid, c.cname, c.grade, c.[order], c.sname,c.actiondate,c.iscurrent,c.subno  
  from BasicData..Class c   
    where kid=(case when @kid<=0 then kid else @kid end) and c.deletetag=1  
 )    
 --select *from Data
 Merge BasicData..class_all ca   
 Using Data b On ca.cid = b.cid and ca.term=@term
 When Matched Then    
 Update Set deletetag=1,cname = b.cname, grade = b.grade, [order] = b.[order]  
 When not Matched Then    
 Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate)   
  Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,@term,0);   
   
--学生 
 --将user_class表数据copy到user_class_all 
 declare @kid int= 15053  ,@term nvarchar(6)='2014-1' 
  ;With Data as (    
 select uc.*
  from BasicData..[User] u 
   inner join BasicData..user_class uc
   on u.userid=uc.userid and u.usertype=0 and kid=@kid
   where u.usertype=0 and kid=@kid
 ) 
 Merge BasicData..user_class_all uca   
 Using Data b On uca.userid=b.userid and uca.term=@term 
 When Matched Then    
 Update Set deletetag=1,cid=b.cid
 When not Matched Then    
 Insert (cid, userid, term, actiondate,deletetag)   
  Values(b.cid, b.userid, @term, getdate(), 1);   

--老师
declare @kid int= 15053,@term nvarchar(6)='2014-1'
Insert into BasicData..user_class_all(cid, userid, term, actiondate,deletetag)   
select uc.cid, uc.userid, @term, getdate(), 1
from BasicData..[User] u 
inner join BasicData..user_class uc
on u.userid=uc.userid
where u.usertype>0 and kid=@kid and not exists
(
select * from BasicData..user_class_all uca
 where uca.userid=uc.userid and uca.cid= uc.cid and uca.term=@term
)
