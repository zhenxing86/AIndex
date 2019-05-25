use ossapp
go
/*  
--作者：xie  
--用途：获取学生资料  
--项目名称：资料导入  
--说明：    
--时间：2015-1-14 11:50:29   
demo:  
  
dataimport_child_GetList 20675,0,'2015-01-15 09:40:42.050',-2  
  
select *From mcapp..cardinfo where card= '1402000002'  
*/    
  
alter PROCEDURE [dbo].[dataimport_child_GetList]            
@kid int,            
@usertype int=0,            
@intimestr datetime='',            
@status int            
            
AS             
            
--成功的资料            
if(@status=1)            
begin            
select cname,uname,gender,birthday,account,regdatetime,mobile,kinno,card1,card2,'成功' result,'',0              
 from excel_input_child            
where kid=@kid and intime=@intimestr and onepass=1             
end            
--失败的资料            
else if(@status=0)            
begin            
              
select e.cname,e.uname,e.gender,e.birthday,e.account,e.regdatetime,e.mobile,e.kinno,e.card1,e.card2,              
(case when u.userid >0 and u.kid>0 then '帐号被'+isnull(k.kname,'kid='+cast(u.kid AS varchar(100)))+u.name+'占用,' else '' end)            
+(case when u.userid >0 and u.kid=0   then '帐号被'+isnull(k.kname,'kid='+cast(lk.kid AS varchar(100)))+'离园用户'+u.name+'占用,' else '' end)              
+(case when c.cid is null then '班级:'+e.cname+'不存在,' else '' end)              
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' ) or (e.mobile is null or e.mobile='')  then '手机错误,' else '' end)              
+(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)              
+(case when (e.account is null or e.account='') then '账号不能为空,' else '' end)              
+ (case when u.userid is null and ex.id>1  then '导入的列表中帐号重复,' else '' end)         
 + (case when e.result like '%6,%' then e.card1+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card1) else '' end)        
 + (case when e.result like '%7,%' then e.card2+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card2) else '' end)          
 + (case when e.result like '%8,%' then e.card1+'重复,' else '' end)        
+ (case when e.result like '%9,%' then e.card2+'重复' else '' end)       
result,              
 (case when u.userid is not null then '1,' else '' end)              
+(case when c.cid is null then '2,' else '' end)              
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' ) or (e.mobile is null or e.mobile='')  then '3,' else '' end)              
+(case when ISDATE(e.birthday)=0 then '4,' else '' end)              
+(case when ex.id>0 then '1,' else '' end)              
+(case when (e.account is null or e.account='') then '1,' else '' end)               
+ isnull(e.result,'') resultnum,              
 e.id             
 from excel_input_child e              
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1             
 --left join excel_input_child ex on ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account             
 outer apply             
 (select COUNT(1) id from excel_input_child ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account)            
 ex            
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1              
  left join basicdata..kindergarten k on k.kid=u.kid and k.deletetag=1           
  left join basicdata..leave_kindergarten lk on u.userid=lk.userid             
where e.kid=@kid and e.intime=@intimestr and e.onepass=0               
end              
--导入的资料            
else if(@status=-1)            
begin            
            
select e.cname,e.uname,e.gender,e.birthday,e.account,e.regdatetime,e.mobile,e.kinno,e.card1,e.card2,            
case when e.nopass=1 then             
(case when u.userid is not null then '帐号重复,' else '' end)  
+ (case when u.userid is null and ex.id>1  then '导入的列表中帐号重复,' else '' end)                
+(case when c.cid is null then '班级不存在,' else '' end)            
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' )  then '手机错误,' else '' end)            
+(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)        
 + (case when e.result like '%6,%' then e.card1+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card1) else '' end)        
 + (case when e.result like '%7,%' then e.card2+'被KID='+(select convert(varchar,kid)+'UserID='+convert(varchar,isnull(userid,''))+'占用,' from mcapp..cardinfo where card=e.card2) else '' end)          
 + (case when e.result like '%8,%' then e.card1+'重复,' else '' end)        
+ (case when e.result like '%9,%' then e.card2+'重复' else '' end)          
else '成功' end            
 result,'',0         
 from excel_input_child e            
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1  
 outer apply             
 (select COUNT(1) id from excel_input_child ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account)            
 ex             
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1            
where e.kid=@kid and e.intime=@intimestr            
              
end            
--basicdata所有资料            
else if(@status=-2)            
begin            
select c.cname,u.name,u.gender,convert(varchar(10),u.birthday,120),u.account,u.regdatetime,u.mobile,0,ca.card1,ca.card2,            
'系统资料' result,'',0   
         
 from basicdata..[user] u             
 inner join basicdata..user_class uc on uc.userid=u.userid            
 inner join basicdata..[class] c on c.cid=uc.cid and c.kid=@kid  
 outer apply  
 (  
 select ISNULL([1],'') as card1,ISNULL([2],'') card2  
 from (select card,ROW_NUMBER()over(partition by ci.userid order by ci.card)rowno   
      from mcapp..cardinfo ci where u.userid=ci.userid and u.deletetag=1) cet  
  pivot(max(card) for rowno in([1],[2])) as p  
 )ca       
where u.kid=@kid and u.usertype=0 and u.deletetag=1 and c.deletetag=1            
end 