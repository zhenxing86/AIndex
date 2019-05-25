20200厦门市海沧区小天鹅幼儿园大三班，王浩小朋友，家园联系册上面没有显示他的名字。

select *from basicdata..[User_Child]  where kid=20200 and  name='王浩'

select *from basicdata..user_class where userid= 880028
select *from basicdata..user_class_all where userid= 880028

insert into basicdata..user_class_all(cid,userid,term,actiondate,deletetag)
select cid,userid,'2014-1',GETDATE(),1
from basicdata..user_class where userid= 880028

------------------------------


declare @t_date datetime,@date datetime='2015-05-25 10:00:00',@ret int=0  
 select @ret=commonfun.dbo.fn_CanSetCurTerm(4246,@date)  
 select @ret  
 
 declare @date datetime=getdate()    
  exec SetCurTerm 4246,@date,1,0        
  
 
--user_clas [order] 同步
;with cet as(     
select uca.*,ROW_NUMBER() over(partition by uca.cid order by uc.name) rows
  from basicdata..user_class uca
 inner join basicdata..[User_Child] uc
  on uca.userid=uc.userid
 where uc.kid =4246 
 )
 update cet set [order] = rows

select * from basicdata..class_all where kid =2670 and term='2015-0'
select * from basicdata..user_class_all uca
 inner join basicdata..class c
  on uca.cid=c.cid and uca.term='2015-0'
   and uca.deletetag=1
 where c.kid =4246 and uca.term='2015-0'
 order by c.cid,uca.[order]
 
 select * 
 --update uca set [order]=uc.[order]
  from basicdata..user_class_all uca
   inner join basicdata..user_class uc
    on uca.userid=uc.userid and uca.term='2015-0' and uca.deletetag=1 
     and uca.[order] is null and uc.[order] is not null
     
     
     select *from basicdata..class where cid=115421  and kid=27984

