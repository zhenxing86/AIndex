  
--按班查询VIP人数
   select t3.vipstatus,t1.userid,t1.name,t1.mobile,commonfun.dbo.fn_cellphone(t1.mobile) mobileview From BasicData.dbo.[user] t1       
   INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid      
   INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid      
   inner join ossapp..addservice t5       
    on t5.[uid]=t1.userid      
     and t5.deletetag=1      
     and t5.describe='开通'      
     and t5.a2='801'      
     and t5.kid=t1.kid      
   where t1.deletetag=1 and t1.mobile is not null     
   and t4.cid in(103794,122809,122810,143386,143387,154043,154044) and t3.vipstatus=1      
   order by t1.name desc    
   

--按幼儿园查询VIP人数 
   select t3.vipstatus,t1.userid,t1.name,t1.mobile,commonfun.dbo.fn_cellphone(t1.mobile) mobileview 
   From BasicData.dbo.[user] t1      
   INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid      
   INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid      
   INNER JOIN BasicData.dbo.class t6 on t4.cid=t6.cid      
   inner join ossapp..addservice t5       
    on t5.[uid]=t1.userid      
     and t5.deletetag=1      
     and t5.describe='开通'      
     and t5.a2='801'      
     and t5.kid=t1.kid      
   where t6.grade <> 38 and t1.deletetag=1 and t1.mobile is not null     
    and t1.kid=3269 and t3.vipstatus=1      
   order by t6.cid    


--查询各班级的VIP人数，手机号正确的VIP人数
   select t3.cid,count(t3.userid) , 
    SUM(case when commonfun.dbo.fn_cellphone(t1.mobile) = 1 then 1 else 0 end)  
     from BasicData.dbo.user_class t3    
     inner join BasicData.dbo.[user] t1     
     on t3.userid=t1.userid     
   INNER JOIN BasicData.dbo.class t6 on t3.cid=t6.cid 
       where t1.deletetag=1    
     --and commonfun.dbo.fn_cellphone(t1.mobile) = 1    
     and t1.usertype=0     
     and t1.kid=3269    
       group by t3.cid  

     
----手机号不正确或者没有填写  
     select t3.cid,t6.cname,t1.*
     from BasicData.dbo.user_class t3    
     inner join BasicData.dbo.[user] t1     
     on t3.userid=t1.userid     
   INNER JOIN BasicData.dbo.class t6 on t3.cid=t6.cid 
       where t1.deletetag=1    
     and commonfun.dbo.fn_cellphone(t1.mobile) = 0   
     and t1.usertype=0     
     and t1.kid=3269  and t3.cid=122810  

select * from ossapp..feestandard where kid=3269
select * from ossapp..addservice a
 --inner join BasicData..User_Child uc on a.userid=uc.userid
 --inner join BasicData..leave_kindergarten lk on a.userid=lk.userid
 
  where a.kid=3269 and describe='开通' 
select * from BasicData..leave_kindergarten where kid= 3269

select * from BasicData..User_Child where kid=3269
   
   
   