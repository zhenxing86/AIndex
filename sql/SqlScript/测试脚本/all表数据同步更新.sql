basicdata..trg_class
commonfun..setcurterm
commonfun..setcurterm_batch


--数据同步
select *from BasicData..[class_all] where cid=96876
select *from BasicData..[user_class] where userid =866275 
select *from BasicData..[user_class_all] where userid =866275 and term='2014-1' 
select *from BasicData..[user] where account='15098703714'



select count(1) from basicdata..[class] c
inner join BasicData..kindergarten k 
       on c.kid = k.kid and k.deletetag=0
where c.deletetag=1 and not exists(
select *from basicdata..[class_all] ca
 where ca.cid=c.cid and ca.term='2014-1' and ca.deletetag=1)

insert into BasicData..user_class_all(cid,userid,term,actiondate,deletetag)
select cid,userid,'2014-1',GETDATE(),1 from BasicData..user_class
where userid=866275

 select count(1) from basicdata..[class_all] where term='2014-1'
 
 select count(1) --uc.cid,userid,@next_term,GETDATE(),1    
     from basicdata..user_class uc  
      inner join basicdata..class c   
       on uc.cid=c.cid   
      inner join BasicData..kindergarten k 
       on c.kid = k.kid and k.deletetag=1
      where not exists(    
       select 1 from BasicData..user_class_all uca    
        where uc.cid=uca.cid and uc.userid =uca.userid   
        and term = '2014-1' and uca.deletetag=1  )


