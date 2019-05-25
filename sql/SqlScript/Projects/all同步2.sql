use BasicData
go

;with cet as(
select userid,cid,term,ROW_NUMBER() over( PARTITION by userid,cid,term order by deletetag desc) rowid 
 from BasicData..[user_class_all]
 --group by userid,cid,term
 --having COUNT(1)>1
) 
delete from cet where rowid>1


select *from BasicData..kindergarten where kid = 29374
select COUNT(1) from BasicData..kindergarten k 
 where deletetag =1 and not exists(
  select 1 from BasicData..kid_term kt 
   where k.kid =kt.kid and kt.term='2017-1'
   )
   
declare @bgndate datetime ,@enddate  datetime
 exec commonfun..Calkidterm 36227, '2017-1', @bgndate output, @enddate output  
 --select @bgndate,@enddate
 ;Merge BasicData..kid_term kt   
 Using (select 36227 kid,'2017-1' term ) b On kt.kid = b.kid and kt.term=b.term  
 When Matched Then    
  Update Set iscurrent=1,douserid=0,dotime=getdate()  
 When not Matched Then    
  Insert (kid,term,bgndate,enddate,iscurrent,douserid,dotime)       
   Values (b.kid,b.term,@bgndate,@enddate,1,0,GETDATE());  

--2 删除多余的脏数据
delete uca
 from basicdata..user_class_all uca
   inner join BasicData..[USER] u 
	  on uca.userid=u.userid --and u.kid= 24013
	   and u.deletetag=1 and usertype=0
  where u.kid=4246 and 
  term='2017-1' and uca.deletetag=1 and usertype=0 and not exists
   ( select 1 from basicdata..user_class uc
      where uca.userid=uc.userid and uca.cid=uc.cid 
   )
   and not exists(select 1 from BasicData..leave_kindergarten lk where lk.userid=uca.userid)

select * from BasicData..User_Child where kid= 4246 and name='伊晓希'
select * from BasicData..[User] where kid= 4246 and account='简玮昕'
select * from BasicData..[User_class] where userid=899541 --152800
select * from BasicData..[User_class_all] where userid=899541 --152800

select * from BasicData..[User_class] where userid=2317658 --152800
select * delete from BasicData..[User_class_all] where userid=2317658 and ucid=10336511 --152800

select * from BasicData..kid_term where kid =36227

select uca.userid,uca.term,COUNT(1) from 
basicdata..user_class_all uca
   inner join BasicData..[USER] u 
	  on uca.userid=u.userid --and u.kid= 24013 
	  and u.deletetag=1 and usertype=0 and term='2017-1'
	  group by uca.userid,uca.term
	  having COUNT(1)>1
   

--查询user_class_all表数据
select uca.*from basicdata..user_class_all uca
	 inner join BasicData..[USER] u 
	  on uca.userid=u.userid and u.kid= 36227 and u.deletetag=1
	   and uca.term='2017-1' and uca.deletetag=1 and actiondate>='2017-15-26'


  
 --同步user_class_all  
 ;with cet as (
	select * from basicdata..kid_term where term='2017-1' 
 )
 insert into user_class_all(cid,userid,term,actiondate,deletetag)    
  select uc.cid,uc.userid,'2017-1',getdate(),1     
   from class c
   inner join cet on c.kid=cet.kid
   inner join user_class uc on c.cid=uc.cid    
   inner join [user] u on uc.userid = u.userid    
    and u.deletetag=1 --and u.usertype >0    
   and c.kid= 20938 
   and not exists(    
    select * from  user_class_all uca where uca.userid=uc.userid and uca.cid=uc.cid     
     and uca.term='2017-1' and uca.deletetag=1    
   ) 


;with Data as(
	select '2017-1' term,*from basicdata..class where  deletetag=1 and kid= 36227 
)
Merge class_all ca 
Using Data b On ca.cid = b.cid and ca.term=b.term and ca.deletetag=1
When Matched Then  
Update Set cname = b.cname, grade = b.grade, [order] = b.[order]
When not Matched Then  
Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
 Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0); 


--user_class_all同步
--1 新增user_class_all表数据
;with Data as(
	select '2017-1' term,uc.*from basicdata..user_class uc
	 inner join BasicData..[USER] u 
	  on uc.userid=u.userid -- and u.kid= 20581 
	  and u.deletetag=1
)
Merge basicdata..user_class_all uca 
Using Data b On uca.userid=b.userid and uca.cid = b.cid and uca.term=b.term 
When Matched and uca.deletetag=0 Then  
Update Set deletetag=1
When not Matched Then  
Insert (cid,userid,term,actiondate,deletetag,[order]) 
 Values(b.cid, b.userid, b.term, getdate(), 1,b.[order]); 
 
 
    select h.hbid, h.term, ca.cname, h.cid           
    from  ngbapp..HomeBook h            
     left join BasicData..class_all ca         
      on h.cid = ca.cid and h.term = ca.term     
       --and ca.deletetag =1       
      left join basicdata..user_class_all uca         
       on ca.cid = uca.cid and ca.term = uca.term      
        and uca.deletetag =1          
    where uca.userid = 2374512     
    --and h.term = @term            
     order by h.CrtDate desc   
     
     select * from ngbapp..HomeBook where cid=154680
     select *from BasicData..class_all where cid=154680
     select *from BasicData..user_class_all where cid=154680 and userid=2374512