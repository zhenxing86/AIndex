use ossapp
go
/*        
-- Author:      xie      
-- Create date: 2015-01-13           
-- Description: 导入用户信息             
-- Memo:             
 stuinfo_AutoSet 17709,0,'',5        
    
dataimport_Set 20675,1,'2015-01-17 11:59:25.933',1,'127.0.0.1'    
-- exec [dataimport_Set] 23115,1,'2014-11-27 15:01:08.220'        
      
--exec mcapp..cardinfo_AutoSet @kid,@inuserid,@ipaddr      
*/       
alter PROCEDURE [dbo].[dataimport_Set]                  
@kid int                 
,@usertype int              
,@intime datetime='1900-1-1'        
,@inuserid int =0      
,@ipaddr nvarchar(100)=NULL                   
 AS                   
                   
begin tran                   
begin try                    
                  
--declare @intime datetime                  
                  
--幼儿设置                  
if(@usertype=0)                  
begin                  
                  
if(@intime<'1950-1-1')                  
begin                  
 select @intime=MAX(intime) from excel_input_child where kid=@kid                  
end                  

update e set result='' from excel_input_child e where e.kid=@kid and intime = @intime    
             
--除了卡号之外的其他信息                  
update e set e.onepass=1,e.nopass=0 from excel_input_child e                   
  left join basicdata..[user] u                   
   on e.account=u.account and u.deletetag=1                  
  left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1                  
  where e.kid=@kid                  
   and ([CommonFun].[dbo].[fn_cellphone](e.mobile)=1 or replace(e.mobile,' ','')='')                  
   and ISDATE(e.birthday)=1                  
   and u.userid is null                  
   and intime = @intime                  
   and c.cid is not null                  
                     
--如果导入的资料Account就有重复                  
update excel_input_child set onepass=0,nopass=1                  
where account in                   
(select account                  
 from excel_input_child e                  
where kid=@kid and intime=@intime                  
group by account having COUNT(1)>1)   
  
--如果卡号被占用（这里控制最多两张）        
update e set e.onepass=0,e.nopass=1,    
result= isnull(result,'')+(case when c.[card] is not null and ((c.userid>0 and c.kid=@kid) or c.kid<>@kid) then '6,' else '' end      
 + case when c2.[card] is not null and ((c2.userid>0 and c2.kid=@kid) or c2.kid<>@kid) then '7,' else '' end)      
 from excel_input_child e       
  left join basicdata..[user] u    
   on e.account=u.account and u.deletetag=1              
  left join mcapp..cardinfo c                 
   on e.card1 = c.[card]     
  left join mcapp..cardinfo c2                 
   on e.card2 = c2.[card]       
  where e.kid=@kid and intime=@intime and (c.[card] is not null or c2.[card] is not null)      
  and (      
  ((u.userid is null and c.userid>0 and c.kid=@kid) or (c.kid is not null and c.kid<>@kid)) or   
  ((u.userid is null and c2.userid>0 and c2.kid=@kid) or (c2.kid is not null and c2.kid<>@kid))      
  )      
  
--如果导入的资料card1就有重复  
;with cet as 
(
select card1 cardno from excel_input_child where kid=@kid and intime=@intime and isnull(card1,'')<>''    
union all
select card2 cardno from excel_input_child where kid=@kid and intime=@intime and isnull(card2,'')<>''
)                
update excel_input_child set onepass=0,nopass=1,
result= isnull(result,'') + '8,'                    
where kid=@kid and intime=@intime and card1 in                   
(select cardno                
 from cet e                                   
group by cardno having COUNT(1)>1)    
--如果导入的资料card2就有重复  
;with cet as 
(
select card1 cardno from excel_input_child where kid=@kid and intime=@intime and isnull(card1,'')<>''
union all
select card2 cardno from excel_input_child where kid=@kid and intime=@intime and isnull(card2,'')<>''
)                
update excel_input_child set onepass=0,nopass=1,
result= isnull(result,'') + '9,'                    
where kid=@kid and intime=@intime and card2 in                   
(select cardno                
 from cet e                                   
group by cardno having COUNT(1)>1)     
--这里忽略卡被注销/作废的情况
          
--修正                  
update e set e.nopass=1 from excel_input_child e                   
  where e.kid=@kid                  
   and intime = @intime                  
   and e.onepass=0                  
                  
--过滤掉8位以内的纯数字帐号留给时光树使用, 网页端不允许使用                  
Update excel_input_child Set onepass = 0, nopass=1 Where commonfun.dbo.fn_RegExMatch(account, N'^\d{1,8}$') = 1                  
               
declare @newaccount table                  
(                  
 nacount varchar(100)                  
)                   
                   
insert into @newaccount(nacount)                  
select e.account from  excel_input_child e                  
left join basicdata..[user] u on e.account=u.account and u.deletetag=1                  
where e.onepass=1 and e.intime = @intime and u.userid is null                  
                   
                   
                  
--插入用户基本表                  
insert into basicdata..[user](name,gender,birthday,account,regdatetime,mobile                  
,[password],usertype,deletetag,kid,nickname                  
,nation,enrollmentdate,headpic,updatetime)                  
select e.uname,e.gender,e.birthday,e.account,GETDATE(),e.mobile                  
,'7C4A8D09CA3762AF61E59520943DC26494F8941B',0,1,@kid,e.uname                  
,6,e.regdatetime,'AttachsFiles/default/headpic/default.jpg',GETDATE()                  
from  excel_input_child e                  
inner join @newaccount n on e.account=nacount                  
where e.onepass=1 and e.intime = @intime                   
    
--获取新增卡号信息                     
 insert into excel_input_temp(id,kid,cname,account,inuserid,card1,card2,userid,birthday,mobile,dname)       
 select e.id,e.kid,cname,e.account,inuserid,    
 case when e.result like '%6,%' or e.result like '%8,%' then '' else card1 end,    
 case when e.result like '%7,%' or e.result like '%9,%' then '' else card2 end,u.userid,isnull(e.birthday,GETDATE()),e.mobile,''    
 from excel_input_child e      
  inner join basicdata..[user] u       
   on e.account=u.account and u.deletetag=1             
  where e.onepass=1 and e.kid=@kid and intime=@intime      
   and inuserid=@inuserid      
                 
declare @temp table                  
(                  
 tcid int,                  
 tcname varchar(100),                  
 tuserid int,                  
 tinuserid int                  
)                  
                  
insert into @temp(tcid,tcname,tuserid,tinuserid)                  
select c.cid,c.cname,u.userid,e.inuserid from excel_input_child e                   
   inner join basicdata..[user] u                   
   on e.account=u.account and u.kid=@kid  and u.deletetag=1                  
   inner join @newaccount n on e.account=nacount                  
   inner join basicdata..[class] c on c.cname=e.cname and c.kid=@kid                  
  where e.kid=@kid                  
   and ([CommonFun].[dbo].[fn_cellphone](e.mobile)=1 or replace(e.mobile,' ','')='')                  
   and ISDATE(e.birthday)=1                  
   and e.intime = @intime                  
   and c.cid is not null                  
   and c.kid=@kid                  
   and c.deletetag=1                  
                  
--插入child表                  
insert into basicdata..[child]([userid],[fathername],[mothername],[favouritething],                  
    [fearthing],[favouritefoot],[footdrugallergic])                    
select tuserid,'','','','','','' from @temp                  
left join basicdata..[child] d on d.userid=tuserid                  
where  d.userid is null                  
     --插入  BasicData..ChildDetails表              
insert into BasicData..ChildDetails([uid],isstay,profession,education,income)              
select t.tuserid,'未填写','未填写','未填写','未填写'  from @temp t left join BasicData..ChildDetails c on t.tuserid=c.[uid]              
and c.ID is null              
                  
--插入user_class表                  
insert into basicdata..[user_class]([cid],[userid])                    
select tcid,tuserid from @temp                  
left join basicdata..[user_class] uc on uc.userid=tuserid                  
where uc.userid is null                  
                  
--插入到user_class_all表                  
declare @term varchar(50)                  
 set @term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)                     
insert into basicdata..user_class_all(cid,userid,term)                   
select tcid,tuserid,@term from @temp t                  
 left join basicdata..user_class_all a on a.userid=t.tuserid and a.term=@term and deletetag=1                  
 where a.ucid is null                  
                  
--插入user_bloguser表                  
INSERT INTO basicdata..user_bloguser(userid)                   
select tuserid from @temp                   
left join basicdata..user_bloguser b on b.userid=tuserid                  
where b.userid is null                  
                  
                  
--ChildDetails_Add存储过程，在有的时候更新，在无的时候新增，所以不需要初始化                  
      
--绑定卡号      
exec mcapp..cardinfo_AutoSet @kid,@inuserid,@ipaddr      
            
                  
--写日志                  
  INSERT INTO reportapp..[rep_child_add_delete](                    
  [userid],[username],[cid],[kid],[actionuserid],[actionusername],[actiontype],[memo],[actiondatetime]                    
  )                  
  select                   
  tuserid,u.name,tcid,@kid,tinuserid,us.name                  
  ,1,'幼儿资料中新增幼儿',getdate()                    
    from @temp                  
    inner join basicdata..[user] u                   
  on u.kid=@kid and u.userid=tuserid                  
 left join ossapp..users us on us.ID=tinuserid                  
                  
                  
--5.添加到临时表                    
insert into basicdata..user_add_temp(userid,usertype,gender,nickname,infofrom,bloguserid)                    
select tuserid,0,gender,name,'blog',b.bloguserid from @temp                   
inner join basicdata..user_bloguser b on b.userid=tuserid                  
inner join basicdata..[user] u on u.kid=@kid and u.userid=tuserid                  
where u.deletetag=1 and u.usertype=0 and u.kid=@kid         
                  
                  
end                  
                  
else if(@usertype<>0)                  
begin                  
                  
if(@intime<'1950-1-1')                  
begin                  
 select @intime=MAX(intime) from excel_input_teacher where kid=@kid                  
end                  
 update e set result='' from excel_input_teacher e where e.kid=@kid and intime = @intime                     
                  
 --更新不错误的                  
 update e set e.onepass=1,e.nopass=0                 
  from excel_input_teacher e                   
  where e.kid=@kid and e.intime = @intime                  
  and ([CommonFun].[dbo].[fn_cellphone](e.mobile)=1 or replace(e.mobile,' ','')='')                   
  and ISDATE(e.birthday)=1                  
  and not exists(select top 1 1 from basicdata..[user] u where e.account=u.account and u.deletetag=1 )                  
  and exists(select top 1 1 from basicdata..class c where c.kid=@kid and (c.cname=e.cname or e.cname='') and c.deletetag=1)                  
  and exists(select top 1 1 from basicdata..department d where d.kid=@kid and d.deletetag=1 and (d.dname=e.dname or e.dname='') )                  
  --and exists(select top 1 1 from basicdata..dict_xml d1 where d1.[Catalog]='最高学历' and (d1.Caption=e.education  or e.education='') )                  
  --and exists(select top 1 1 from basicdata..dict_xml d2 where d2.[Catalog]='政治面貌' and (d2.Caption=e.politicalface or e.politicalface='') )                  
  --and exists(select top 1 1 from basicdata..dict_xml d3 where d3.[Catalog]='专业技术职务' and (d3.Caption=e.post or e.post in ('','无')) )                  
  --and exists(select top 1 1 from basicdata..dict_xml d4 where d4.[Catalog]='任职类别' and (d4.Caption=e.title or e.title in ('','老师')) )                  
  
--如果导入的资料就有重复                  
update excel_input_teacher set onepass=0,nopass=1                  
where account in                   
(select account                  
 from excel_input_teacher e                  
where kid=@kid and intime=@intime                  
group by account having COUNT(1)>1)      
       
  --如果卡号被占用（这里控制最多两张）        
update e set e.onepass=0,e.nopass=1,      
result= isnull(result,'') + (case when c.[card] is not null and ((c.userid>0 and c.kid=@kid) or c.kid<>@kid) then '6,' else '' end      
 + case when c2.[card] is not null and ((c2.userid>0 and c2.kid=@kid) or c2.kid<>@kid) then '7,' else '' end)      
 from excel_input_teacher e     
  left join basicdata..[user] u    
   on e.account=u.account and u.deletetag=1                   
  left join mcapp..cardinfo c                 
   on e.card1 = c.[card]        
  left join mcapp..cardinfo c2                 
   on e.card2 = c2.[card]       
  where e.kid=@kid and intime=@intime and (c.[card] is not null or c2.[card] is not null)      
  and (      
  ((u.userid is null and c.userid>0 and c.kid=@kid) or (c.kid is not null and c.kid<>@kid)) or   
  ((u.userid is null and c2.userid>0 and c2.kid=@kid) or (c2.kid is not null and c2.kid<>@kid))      
  ) 

--如果导入的资料card1就有重复  
;with cet as 
(
select card1 cardno from excel_input_teacher where kid=@kid and intime=@intime and isnull(card1,'')<>''
union all
select card2 cardno from excel_input_teacher where kid=@kid and intime=@intime and isnull(card2,'')<>''
)                
update excel_input_teacher set onepass=0,nopass=1,
result= isnull(result,'') + '8,'                    
where kid=@kid and intime=@intime and card1 in                   
(select cardno                
 from cet e                                   
group by cardno having COUNT(1)>1)    
--如果导入的资料card2就有重复  
;with cet as 
(
select card1 cardno from excel_input_teacher where kid=@kid and intime=@intime and isnull(card1,'')<>''
union all
select card2 cardno from excel_input_teacher where kid=@kid and intime=@intime and isnull(card2,'')<>''
)                
update excel_input_teacher set onepass=0,nopass=1,
result= isnull(result,'') + '9,'                    
where kid=@kid and intime=@intime and card2 in                   
(select cardno                
 from cet e                                   
group by cardno having COUNT(1)>1) 
    
--这里忽略卡被注销/作废的情况      
             
 declare @newtaccount table                  
 (                  
  nacount varchar(100)                  
 )                   
                    
 insert into @newtaccount(nacount)                  
 select e.account from  excel_input_teacher e                  
 left join basicdata..[user] u on e.account=u.account and u.deletetag=1                  
 where e.onepass=1 and e.intime = @intime and u.userid is null                  
                
 --插入用户基本表                  
 insert into basicdata..[user](name,gender,birthday,account,regdatetime,mobile                  
 ,[password],usertype,deletetag,kid,nickname                  
 ,nation,enrollmentdate,headpic,updatetime)                                
 select e.uname,e.gender,e.birthday,e.account,GETDATE(),e.mobile                  
 ,'7C4A8D09CA3762AF61E59520943DC26494F8941B',(case e.title when '园长' then 97 when '管理员' then 98 else 1 end),1,@kid,e.uname                  
 ,6,GETDATE(),'AttachsFiles/default/headpic/default.jpg',GETDATE()                  
 from  excel_input_teacher e                  
  inner join @newtaccount n on e.account=nacount                  
 where e.onepass=1  and e.intime = @intime                  
    
--获取新增卡号信息                     
 insert into excel_input_temp(id,kid,cname,account,inuserid,card1,card2,userid,birthday,mobile,dname)       
 select e.id,e.kid,cname,e.account,inuserid,    
 case when e.result like '%6,%' or e.result like '%8,%' then '' else card1 end,    
 case when e.result like '%7,%' or e.result like '%9,%' then '' else card2 end,u.userid,isnull(e.birthday,GETDATE()),e.mobile,isnull(e.dname,'')    
 from excel_input_teacher e      
  inner join basicdata..[user] u       
   on e.account=u.account and u.deletetag=1             
  where e.onepass=1 and e.kid=@kid and intime=@intime      
   and inuserid=@inuserid     
                 
  --配置权限开始                
   DECLARE  @org_id int                 
                   
   SELECT @org_id = org_id   FROM kwebcms..[site]    WHERE siteid = @kid                    
                  
  declare @tb_user table(appuserid int,usertype int,kid int,                 
  account nvarchar(50),username nvarchar(50),role_id int,role_name nvarchar(50),pwd varchar(50),[user_id] int)                
                  
  insert into @tb_user(appuserid,usertype,kid,account,username,role_name,pwd)                
  select  u.userid,u.usertype,u.kid,u.account,u.name,e.title,u.[password] from  excel_input_teacher e                  
  inner join @newtaccount n on e.account=nacount                  
  left join basicdata..[user] u on u.account=e.account and u.deletetag=1 and u.kid=e.kid and u.usertype>1                
  left join kwebcms..site_user  su on u.userid=su.appuserid                 
 where e.onepass=1  and e.intime = @intime  and (e.title='园长' or e.title='管理员') and   su.[UID] is null and su.userid is null                
                 
   --更新@tb_user 的 role_id                
    declare  @tb_role table(rolename nvarchar(50),roleid int)                
   insert into @tb_role(rolename,roleid) select  r.role_name,r.role_id   from  KWebCMS_Right..sac_role r  left join KWebCMS_Right..sac_site_instance i on r.site_instance_id=i.site_instance_id                
  where i.org_id=@org_id                
                  
  update t set t.role_id=r.roleid  from @tb_user t join  @tb_role r on t.role_name=r.rolename                 
                  
  --插入KWebCMS_Right.dbo.sac_user                
  insert into KWebCMS_Right.dbo.sac_user(account,[password],username,org_id,[status])                
  select t.account,t.pwd,t.username,@org_id,1  from @tb_user  t                 
  left join   KWebCMS_Right.dbo.sac_user s on t.account=s.account and s.status=1                
   where s.user_id is null                
 --更新@tb_user 的user_id                
 update  t set t.[user_id]=s.[user_id] from  @tb_user t join KWebCMS_Right.dbo.sac_user s on t.account=s.account and s.status=1                 
 where s.user_id>0                
  --插入KWebCMS..site_user                  
  insert into KWebCMS..site_user(siteid,account,password,name,usertype,UID,appuserid)                
  select t.kid,t.account,t.pwd,t.username,t.usertype,t.[user_id],t.appuserid from @tb_user t  left join KWebCMS..site_user s                 
  on t.user_id=s.UID and t.appuserid=s.appuserid where s.userid is null                
   --插入 KWebCMS_Right.dbo.sac_user_role                
   insert into  KWebCMS_Right.dbo.sac_user_role(user_id,role_id)                 
   select t.user_id,t.role_id from @tb_user t left join KWebCMS_Right.dbo.sac_user_role r                 
    on t.user_id=r.user_id and t.role_id=t.role_id where r.id is null                
    --配置权限结束                
                  
 declare @temptea table                  
 (                  
  tdid int,                  
  tdname varchar(100),                  
  tcid int,                  
  tcname varchar(100),                  
  tuserid int,                  
  tinuserid int,                  
  ttitle varchar(100),                  
  tpost varchar(100),                  
  teducation varchar(100),                  
  tpoliticalface varchar(100),                  
  tkinschooltag int                  
 )                  
                  
 insert into @temptea(tdid,tdname,tcid,tcname,tuserid,tinuserid,ttitle,tpost,teducation,tpoliticalface,tkinschooltag)                  
 select d.did,d.dname,c.cid,c.cname,u.userid,e.inuserid,e.title,e.post,e.education,e.politicalface,e.kinschooltag                   
   from excel_input_teacher e                   
   inner join basicdata..[user] u                   
    on e.account=u.account and u.kid=@kid  and u.deletetag=1                  
   inner join @newtaccount n on e.account=nacount                  
   left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1                   
   cross apply (                  
    select top 1 did,dname,deletetag from basicdata..department dx                   
    where dx.dname=case when e.dname=''then dx.dname else e.dname end and dx.kid=@kid             
    order by case when e.dname!=''then 0 else 1 end ,did            
   ) d                  
   where e.kid=@kid                  
    and d.deletetag=1                  
    and e.intime = @intime                  
     and (e.cname='' or ( c.kid=@kid and c.deletetag=1))          
    and e.onepass=1                  
                  
                
                  
 --插入teacher表                  
 insert into basicdata..[teacher]([userid],did,title,post,education,politicalface,kinschooltag,orderno)                    
 select tuserid,tdid,ttitle,tpost,teducation,tpoliticalface,tkinschooltag,0 from @temptea                  
 left join basicdata..teacher d on d.userid=tuserid                  
 where  d.userid is null                  
                  
 --插入user_class表                  
 insert into basicdata..[user_class]([cid],[userid])                    
 select tcid,tuserid from @temptea                  
 left join basicdata..[user_class] uc on uc.userid=tuserid                  
 where uc.userid is null and tcid is not null and tcid <>''                  
                  
 --插入到user_class_all表                  
declare @term1 varchar(50)                  
 set @term1=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)                     
insert into basicdata..user_class_all(cid,userid,term)                   
select tcid,tuserid,@term1 from @temptea where tcid>0               
                   
                  
 --插入user_bloguser表                  
 INSERT INTO basicdata..user_bloguser(userid)                   
 select tuserid from @temptea                   
 left join basicdata..user_bloguser b on b.userid=tuserid                  
 where b.userid is null                  
                  
                  
 ----TeacherDetails_Add存储过程，在有的时候更新，在无的时候新增，所以不需要初始化                  
                  
 --写日志                  
   INSERT INTO reportapp..[rep_child_add_delete](                    
   [userid],[username],[cid],[kid],[actionuserid],[actionusername],[actiontype],[memo],[actiondatetime]                    
   )                  
   select                   
   tuserid,u.name,tcid,@kid,tinuserid,us.name                  
   ,1,'老师资料中导入老师',getdate()                    
  from @temptea                  
  inner join basicdata..[user] u                   
   on u.kid=@kid and u.userid=tuserid                  
  left join ossapp..users us on us.ID=tinuserid                  
                  
                  
 --5.添加到临时表                    
 insert into basicdata..user_add_temp(userid,usertype,gender,nickname,infofrom,bloguserid)                    
 select tuserid,0,gender,name,'blog',b.bloguserid from @temptea                   
 inner join basicdata..user_bloguser b on b.userid=tuserid                  
 inner join basicdata..[user] u on u.kid=@kid and u.userid=tuserid                  
 where u.deletetag=1 and u.usertype=0 and u.kid=@kid                  
                  
                  
 --接送卡                  
 if exists (SELECT  1 FROM blogapp..permissionsetting WHERE kid=@kid and ptype=12)                  
  begin                  
   insert into CardApp..SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)                    
   select t1.kid as kid,0 as subno,t1.userid,1,t1.name,t1.name,'' as classname,'' as pwd,0,getdate() as actiondate,0 as synstatus                    
   from basicdata..[user] t1                    
   inner join  @temptea on t1.userid=tuserid                  
  end                  
 end                  
                   
                  
--自动补充教师资料                  
insert into BasicData..teacher(userid,did)                  
select u.userid,d.did from BasicData..[user] u                  
left join BasicData..teacher t on t.userid=u.userid                  
outer apply                   
(select top 1 d.did from BasicData..department d where d.kid=u.kid) d                   
where u.usertype in (1,97) and t.userid  is null and u.kid<>0                  
                   
                   
 --自动补充blog_userid                  
 insert into BasicData..user_bloguser(userid)                  
select u.userid from BasicData..[user] u                   
left join BasicData..user_bloguser ub                   
on ub.userid=u.userid                  
where ub.bloguserid is null and deletetag=1          
      
--绑定卡号      
exec mcapp..cardinfo_AutoSet @kid,@inuserid,@ipaddr              
                   
commit tran                  
end try                  
begin catch                  
 rollback tran                   
 SELECT ERROR_NUMBER() as ErrorNumber,                  
        ERROR_MESSAGE() as ErrorMessage;                  
end catch   
  