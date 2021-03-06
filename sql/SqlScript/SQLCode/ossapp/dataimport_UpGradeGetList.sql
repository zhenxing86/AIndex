USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_UpGradeGetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--升班导资料获取列表       dataimport_UpGradeGetList 23115,'2014-08-14 11:00:41.947' ,0,'',''       
CREATE PROCEDURE [dbo].[dataimport_UpGradeGetList]                
@kid int,               
@intimestr datetime='',                
@status int ,               
@usertype int=0,        
@username nvarchar(50)='',        
@classname nvarchar(50)=''          
AS                 
 declare @usertypemsg nvarchar(500)            
 if(@usertype=0)            
 begin            
 set @usertypemsg='该登录名的角色不是学生'            
 end            
 else            
 begin            
  set @usertypemsg='该登录名的角色是学生'            
 end               
--成功的资料                
if(@status=1)                
begin                
select  cname,uname,account,'成功' result                
 from excel_upgrade_child                
where kid=@kid and intime=@intimestr and onepass=1  and  uname like @username+'%'  and  cname like @classname+'%'    and deletag=1         
end                
--失败的资料                
else if(@status=0)                
begin  
--纠正数据
update excel_upgrade_child set onepass=1
where kid=@kid and intime=@intimestr and deletag=1 and nopass=0

              
select distinct e.cname,e.uname,e.account,       
(case when u.userid is null  then '帐号不存在,' else '' end)    
+(case when len(e.uname)<1  then '姓名不能为空,' else '' end)    
+(case when c.cid is null then '班级:'+e.cname+'不存在,' else '' end)                     
+(case when (e.account is null or e.account='') then '账号不能为空,' else '' end)                  
+ (case when ex.id>1    then '导入的列表中帐号重复,' else '' end)              
+ (case when u.userid is not null  and k.kid>0 and u.kid<>@kid   then '账号属于'+k.kname+',' else '' end)       
+ (case when uc.account is not null And  uc.account<>u.account  then '姓名'+e.uname+'的账号为'+uc.account+',' else '' end)      
+ (case when u.userid is not null  and k.kid>0 and u.kid=@kid and uc.account is  null  then '姓名'+e.uname+'不属于'+k.kname+',' else '' end)             
+ (case when u.userid is not null and k.kid is null and l.userid is  null then '账号属于'+cast(u.kid AS varchar(50))+'并且该幼儿园不存在,' else '' end)            
+(case when uc.name is null and len(e.uname)>1  then '姓名:'+e.uname+'不存在,' else '' end)               
+(case when  e.uname<>u.name and @kid=u.kid then '登录名:'+e.account+'的姓名为'+u.name+',' else '' end)             
+(case when  u.usertype<>@usertype then @usertypemsg+',' else '' end)   
+ (case when  l.userid>0 and l.kid=@kid  then '账号于'+CONVERT(varchar(100), l.outtime, 20)+'离园了,' else '' end) --离园 并且不属于该幼儿园  
+ (case when  l.userid>0 and l.kid<>@kid  then '账号于'+CONVERT(varchar(100), l.outtime, 20)+'离园了,并且属于'+lk.kname  else '' end) --离园   
+(case when aeu.userid >1  then '存在'+cast(aeu.userid as varchar(50))+'个姓名相同的幼儿,' else '' end)  --该幼儿园存在多条姓名相同的记录         
 result,                  
 (case when u.userid is  null then '1,4,' else '' end)           
 + (case when u.userid is  null and c.cid>0 then '5,' else '' end) --账号不存在的时候可以做新增处理                 
+(case when c.cid is null then '2,' else '' end)                  
+(case when   ex.id>1 then '1,' else '' end)                  
+(case when (e.account is null or e.account='') then '1,' else '' end)              
+ (case when u.userid is not null and k.kid>0 and u.kid<>@kid then '1,' else '' end)     
+ (case when  uc.account is not null  then '1,4,' else '' end)      
+ (case when u.userid is not null  and k.kid>0 and u.kid=@kid and uc.account is  null  then '3,4,' else '' end)                
+ (case when u.userid is not null and k.kid is null then '1,4' else '' end)              
+(case when  u.usertype<>@usertype then '1,' else '' end)    
+(case when  e.uname<>u.name and @kid=u.kid then '1,4,' else '' end)      
+(case when uc.name is null and len(e.uname)>1 then '4,' else '' end)      
+(case when len(e.uname)<1  then '4,' else '' end)            
+(case when aeu.userid >1  then '4,1,' else '' end)  --该幼儿园存在多条姓名相同的记录   
 resultnum,                  
 e.id  ,e.deletag                 
 from excel_upgrade_child e                  
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1        
  left join basicdata..[user] uc on  uc.name=e.uname and uc.deletetag=1 and uc.kid=@kid           
 --left join excel_upgrade_child ex on ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account                 
 outer apply                 
 (select COUNT(1) id from excel_upgrade_child ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account and deletag=1)                
 ex      
 outer apply  
 (  
 select COUNT(1) userid from basicdata..[user] au where  au.kid=@kid And au.name=e.uname and au.deletetag=1  
 )     
 aeu         
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1                  
  left join ossapp..kinbaseinfo k on k.kid=u.kid and k.deletetag=1     
  left join basicdata..leave_kindergarten l on l.userid=u.userid    
  left join basicdata..kindergarten  lk on lk.kid=l.kid            
where e.kid=@kid and e.intime=@intimestr and e.onepass=0  and e.uname like @username+'%'  and e.cname like @classname+'%'    and e.deletag=1   
order by e.uname         
end                  
--导入的资料                
else if(@status=-1)                
begin                
                
select e.cname,e.uname,e.account,                
case when e.nopass=1 then                 
(case when u.userid is  null then '帐号不存在,' else '' end)                
+(case when c.cid is null then '班级不存在,' else '' end)                
else '成功' end                
 result,e.intime                
 from excel_upgrade_child e                
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1                
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1                
where e.kid=@kid and e.intime=@intimestr and e.deletag=1    
                  
end                
--basicdata所有资料                
else if(@status=-2)                
begin                
select c.cname,u.name,u.account,              
'系统资料' result                
 from basicdata..[user] u                 
 inner join basicdata..user_class uc on uc.userid=u.userid                
 inner join basicdata..[class] c on c.cid=uc.cid and c.kid=@kid                
where u.kid=@kid and u.usertype=0 and u.deletetag=1 and c.deletetag=1                
end 
GO
