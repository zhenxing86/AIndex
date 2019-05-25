use ossapp
go
/*    
--作者：xie    
--用途：判断卡号是否已经被占用    
--项目名称：资料导入    
--说明：      
--时间：2015-1-14 11:50:29     
demo:    
    
dataimport_teacher_GetList 20675,1,'2015-01-17 10:09:07.643',0   
    
select *From excel_input_teacher where kid=20675    
select *From mcapp..cardinfo where card= '1402000002'    
*/      
    
alter PROCEDURE [dbo].[dataimport_teacher_GetList]          
@kid int,          
@usertype int=1,          
@intimestr datetime='',          
@status int          
          
AS           
          
 --成功的资料          
 if(@status=1)          
 begin          
 select dname,cname,uname,gender,birthday,account,mobile,title,post,education,politicalface,kinschooltag,card1,card2,'成功' result,'',0           
  from excel_input_teacher          
 where kid=@kid and intime=@intimestr and onepass=1           
 end          
 --失败的资料          
 else if(@status=0)          
 begin          
  select e.dname,e.cname,e.uname,e.gender,e.birthday,e.account,e.mobile,e.title,e.post,e.education,e.politicalface,e.kinschooltag,e.card1,e.card2,            
 (case when u.userid >0  then '帐号被'+isnull(k.kname,'kid='+cast(u.kid AS varchar(100)))+u.name+'占用,' else '' end)            
 +(case when d.did is null then '部门:'+e.dname+'不存在,' else '' end)            
 +(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' )  then '手机错误,' else '' end)            
 +(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)            
 +(case when (e.account is null or e.account='') then '账号不能为空,' else '' end)            
 + (case when  u.userid is null and  ex.id>1  then '导入的列表中帐号重复,' else '' end)         
 + (case when e.result like '%6,%' then e.card1+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card1) else '' end)        
 + (case when e.result like '%7,%' then e.card2+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card2) else '' end)          
 + (case when e.result like '%8,%' then e.card1+'重复,' else '' end)        
 + (case when e.result like '%9,%' then e.card2+'重复' else '' end)  
 result,            
  (case when u.userid is not null or ex.id>1 then '1,' else '' end)            
 +(case when d.did is null then '2,' else '' end)            
 +(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' or (e.mobile is null or e.mobile='') )  then '3,' else '' end)            
 +(case when ISDATE(e.birthday)=0 then '4,' else '' end)            
 +(case when (e.account is null or e.account='') then '1,' else '' end)             
  +(case when (c.cname is null) then '5,' else '' end)     
  + isnull(e.result,'')        
  resultnum,            
  e.id            
  from excel_input_teacher e            
  left join basicdata..[user] u on  u.account=e.account and u.deletetag=1            
     outer apply           
 (select COUNT(1) id from excel_input_teacher ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account) ex          
  left join basicdata..department d on d.dname=e.dname and d.kid=@kid and d.deletetag=1            
  left join basicdata..kindergarten k on k.kid=u.kid and k.deletetag=1            
  left join basicdata..class c on e.cname=c.cname and c.kid=@kid and c.deletetag=1            
 where e.kid=@kid and e.intime=@intimestr and e.onepass=0             
 end            
 --导入的资料          
 else if(@status=-1)          
 begin          
          
 select e.dname,e.cname,e.uname,e.gender,e.birthday,e.account,e.mobile,e.title,e.post,e.education,e.politicalface,e.kinschooltag,e.card1,e.card2,          
 case when e.nopass=1 then (case when u.userid is not null then '帐号重复,' else '' end)   
 + (case when  u.userid is null and  ex.id>1  then '导入的列表中帐号重复,' else '' end)         
 +(case when d.did is null then '部门不存在,' else '' end)          
 +(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' )  then '手机错误,' else '' end)          
 +(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)    
 + (case when e.result like '%6,%' then e.card1+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card1) else '' end)        
 + (case when e.result like '%7,%' then e.card2+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card2) else '' end)          
 + (case when e.result like '%8,%' then e.card1+'重复,' else '' end)        
+ (case when e.result like '%9,%' then e.card2+'重复' else '' end)         
 else '成功' end          
  result,'',0          
  from excel_input_teacher e          
  left join basicdata..[user] u on  u.account=e.account and u.deletetag=1   
  outer apply           
 (select COUNT(1) id from excel_input_teacher ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account) ex          
  left join basicdata..department d on d.dname=e.dname and d.kid=@kid and d.deletetag=1          
 where e.kid=@kid and e.intime=@intimestr          
            
 end          
 --basicdata所有资料          
 else if(@status=-2)          
 begin          
           
  select dname,cname,u.name,gender,birthday,account,mobile,t.title,post,education,politicalface,kinschooltag,ca.card1,ca.card2,'系统资料' result,'',0        
   from basicdata..User_Teacher u          
   inner join basicdata..department d on d.did=u.did          
   inner join basicdata..teacher t on t.userid=u.userid          
   outer apply(          
    select max(cname) cname from basicdata..user_class uc          
     inner join basicdata..class c on c.cid=uc.cid          
     where uc.userid=u.userid          
    ) as classname      
  outer apply    
 (    
 select ISNULL([1],'') as card1,ISNULL([2],'') card2    
 from (select card,ROW_NUMBER()over(partition by ci.userid order by ci.card)rowno     
      from mcapp..cardinfo ci where u.userid=ci.userid) cet    
  pivot(max(card) for rowno in([1],[2])) as p    
 )ca        
  where u.kid=@kid and u.usertype<>98            
           
 end 