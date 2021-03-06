use mcapp
go
/*------------------------------------          
--用途：查询记录信息           
--项目名称：          
--说明：          
--时间：2012-10-16 21:55:38          
--[getstuupdatelist] 8812,'000881201'          
--[GetStuInfoUpdateStatus] 12511,'001251102',0,'2013-08-09 09:02:01'          
--[getstuupdatelist] 8812,'00881201',0,'2013-01-05 16:32:45'          

[getstuupdatelist] 8812,'0000881200',0,'2013-01-05 16:32:45'       

 getstuupdatelist2 8812,'0000881200',0,'2013-01-05 16:32:45'   
 
 select *from basicdata..[user] where kid= 8812 and name='李泽铭'

select * from BlogApp..permissionsetting where kid = 8812 and ptype=70
    
------------------------------------ */         
alter PROCEDURE [dbo].[getstuupdatelist]          
 @kid int,          
 @devid varchar(10),          
 @cnt int,          
 @l_update datetime          
 AS          
BEGIN         
    
declare @user table(userid int,name nvarchar(50),sex nvarchar(10),cardno nvarchar(50),    
 cname nvarchar(100),birthday datetime,tts nvarchar(50),sname nvarchar(50),rowno int)    
     
 if(@cnt =0)          
 begin      
 insert into @user        
  select uc.userid,uc.name,uc.sex,          
      c.cardno,uc.cname,uc.birthday,uc.tts,uc.sname,         
      ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno       
   from BasicData..user_Child uc      
     left join cardinfo c             
     on uc.userid=c.userid and c.kid= uc.kid           
   where uc.kid = @kid           
    and uc.cid > 0           
    and uc.grade<>38         
 end          
 else          
 begin      
 insert into @user              
  select uc.userid,uc.name,uc.sex,          
      c.cardno,uc.cname,uc.birthday,uc.tts,sname,         
      ROW_NUMBER()over(partition by uc.userid order by c.cardno)rowno     
   from BasicData..user_Child uc         
     left join cardinfo c             
     on uc.userid=c.userid  and c.kid= uc.kid          
   where uc.kid = @kid           
    and uc.updatetime >= @l_update           
    and uc.cid > 0           
    and uc.grade <> 38          
 end      
    
 --select * from @user  
 if exists(select * from BlogApp..permissionsetting where kid = @kid and ptype=70)      
 begin    
  --不开vip可开卡    
   select userid stuid, ISNULL([1],'') as card1,          
      ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4,          
      name, case sex when '女' then '0' when '男' then '1' end sex, 
      cname,CONVERT(VARCHAR(10),isnull(birthday, '2010-01-01'),120) birth, tts,Isnull(sname, '') sname          
   from @user u          
    pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p  
end    
else    
begin    
   --需要开通vip    
   select uc.userid,uc.name,sex,          
      uc.cardno,uc.cname,uc.birthday,uc.tts,uc.sname,uc.rowno  into #RESULT     
    from @user uc     
     inner join ossapp..addservice a      
   on a.deletetag=1 and uc.userid=a.[uid] and a.describe='开通'    
   and a.ftime<=GETDATE() And a.ltime>=GETDATE() and a.a8 >0         
      
   select userid stuid, ISNULL([1],'') as card1,          
      ISNULL([2],'') card2,ISNULL([3],'') card3,ISNULL([4],'') card4,          
      name, case sex when '女' then '0' when '男' then '1' end sex, 
      cname,CONVERT(VARCHAR(10),isnull(birthday, '2010-01-01'),120) birth, tts,Isnull(sname, '') sname          
   from #RESULT    
    pivot(max(cardno) for rowno in([1],[2],[3],[4])) as p       
        
   drop table #RESULT    
end    
        
          
END 