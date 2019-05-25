declare @kid int=19457
select uc.cid,count(1) from [User] u 
 inner join  user_class_all uc on uc.term='2014-0' and u.userid=uc.userid and uc.deletetag=1 and u.deletetag=1
 where u.kid=@kid group by uc.cid order by uc.cid

select uc.cid,count(1) from [User] u 
 inner join  user_class_all uc on uc.term='2014-1' and u.userid=uc.userid and uc.deletetag=1 and u.deletetag=1
 where u.kid=@kid group by uc.cid order by uc.cid
 
 帐号：13826191504	
 



select*from BasicData..kindergarten where kname='振兴的幼儿园'
  select *from [user] where kid = 24007 and usertype>0
 select *from class_all where kid = 24007 and term='2014-1'



 
 --清除数据
 --delete from kid_term where kid=24007
 --delete from class_all where kid =24007
 -- delete uca 
 -- from user_class_all uca
 -- inner join class c on uca.cid=c.cid and uca.term='2014-1' where kid =24007
 
 select cid,cname,term,count(cid) from class_all where deletetag=1 and kid=24082 group by cid,cname,term
 having count(cid)>1
 
 --Delete a 
 -- From BasicData.dbo.class_all a 
 -- Where deletetag=1 and term= '2014-1' and Exists (Select * From BasicData.dbo.class_all b 
 --                 Where a.term = b.term and a.cid = b.cid and deletetag=1
 --                 Group by b.term, b.cid
 --                 Having a.ID <> MAX(b.ID))
 
 
 --class_all where kid= 18487 and term='2014-1'
 --同步class_all
 ;with cet as (
 select * from kid_term where term='2014-1' and kid=24007
 )
 insert into class_all(cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
 select b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,subno,'2014-1',0
  from class b 
   inner join cet on b.kid=cet.kid
   and b.kid = 21861 
   and not exists(
    select * from class_all ca where b.cid=ca.cid and ca.term='2014-1' and ca.deletetag=1
    )
    
 --同步user_class_all  
 ;with cet as (
	select * from kid_term where term='2014-1' 
 )
 --insert into user_class_all(cid,userid,term,actiondate,deletetag)    
  select uc.cid,uc.userid,'2014-1',getdate(),1     
   from class c
   inner join cet on c.kid=cet.kid
   inner join user_class uc on c.cid=uc.cid    
   inner join [user] u on uc.userid = u.userid    
    and u.deletetag=1 --and u.usertype >0    
   --and c.kid= 18487 
   and not exists(    
    select * from  user_class_all uca where uca.userid=uc.userid and uca.cid=uc.cid     
     and uca.term='2014-1' and uca.deletetag=1    
   ) 

;with Data as(
	select '2014-0' term,*from basicdata1407..class where  deletetag=1 --kid= 18487 and
)
Merge class_all ca 
		Using Data b On ca.cid = b.cid and ca.term=b.term and ca.deletetag=1
		When Matched Then  
		Update Set cname = b.cname, grade = b.grade, [order] = b.[order]
		When not Matched Then  
		Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
		 Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0); 

select *into user_class_all_bak 

--delete from user_class_all where term='2014-0'
;with Data as(
	select '2014-0' term,*  select count(1) from basicdata1407..user_class --kid= 18487 and
)
insert into user_class_all(cid,userid,term,actiondate,deletetag)
select cid,userid,term,GETDATE(),1
from Data

Merge user_class_all ca 
		Using Data b On ca.cid = b.cid and ca.term=b.term and ca.deletetag=1
		When Matched Then  
		Update Set cname = b.cname, grade = b.grade, [order] = b.[order]
		When not Matched Then  
		Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
		 Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0); 
		 