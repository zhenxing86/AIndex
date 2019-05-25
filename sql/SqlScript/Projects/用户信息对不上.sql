SELECT COUNT(1)  
   FROM [user_child] u   
    left join leave_kindergarten lk on u.userid = lk.userid  
   WHERE  u.kid = 12511   
    and lk.userid is null  
     
     SELECT COUNT(1)  
   FROM [user] u   
    left join leave_kindergarten lk on u.userid = lk.userid  
   WHERE  u.kid = 12511 and deletetag=1 and usertype =0 and lk.userid is null  
   377
     48
   335
   
   select update u set deletetag = 0
   from [user] u 
    left join leave_kindergarten lk on u.userid = lk.userid  
    left join [user_child] uc on u.userid=uc.userid 
    where u.kid = 12511 and u.deletetag=1 and u.usertype=0 and uc.userid is null and lk.userid is null
   
   
   select * leave_kindergarten from 
    
   select *from leave_kindergarten lk
    inner join [user] u  on u.userid=lk.userid  and u.usertype =0
   inner join [user_child] uc  on uc.userid = lk.userid  
   where u.kid = 12511
   
   
   ÖÜÐ¦·«   
   
   select *from basicdata..[user] u where name='ÖÜÐ¦·«' kid=  14084 and 
   
   user_GetListByName
   user_GetCountByName
   
   SELECT COUNT(1)  
   FROM [user_child] u   
    left join leave_kindergarten lk on u.userid = lk.userid  
   WHERE u.kid = 12511   
    and lk.userid is null 
    
    
    select *from mcapp..cardinfo where card = '1307008871'