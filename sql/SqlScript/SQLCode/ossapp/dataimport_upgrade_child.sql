USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_child]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--导资料幼儿升班,操作此之前必须是全部完成升班操作的            
CREATE PROCEDURE [dbo].[dataimport_upgrade_child]            
@kid int,            
@intime datetime='1900-1-1',            
@term varchar(200)            
 AS             
             
begin tran             
begin try              
--幼儿设置            
            
if(@intime<'1950-1-1')            
begin            
 select @intime=MAX(intime) from excel_upgrade_child where kid=@kid            
end            
            
update e set e.onepass=1,e.nopass=0 from excel_upgrade_child e             
  left join basicdata..[user] u             
   on e.account=u.account and u.deletetag=1  and u.kid=@kid          
  left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1            
  where e.kid=@kid            
   and u.usertype=0            
   and u.userid is not null            
   and intime = @intime            
   and c.cid is not null            
   and u.name=e.uname            
  --去除重复的资料，只保留一条      
   update e set deletag=0      
  from ossapp..excel_upgrade_child e       
  left join (select account,uname,cname from  ossapp..excel_upgrade_child      
 where kid=@kid and intime=@intime and deletag=1      
 group by cname,account,uname having COUNT(1)>1) b on e.account=b.account and e.cname=b.cname and e.uname=b.uname      
 where kid=@kid and intime=@intime and e.id not in      
 (select MIN(id)   from ossapp..excel_upgrade_child where kid=@kid and intime=@intime and deletag=1      
  group by cname,account,uname having COUNT(1)>1) and b.account is not null      
               
--如果导入的资料账号，用户名重复          
update excel_upgrade_child set onepass=0,nopass=1            
where account in             
(select account            
 from excel_upgrade_child e            
where kid=@kid and intime=@intime and deletag=1        
group by account,uname having COUNT(1)>1)               
--修正            
update e set e.nopass=1 from excel_upgrade_child e             
  where e.kid=@kid            
   and intime = @intime            
   and e.onepass=0            
            
declare @newaccount table            
(            
 nacount varchar(100)            
)             
             
insert into @newaccount(nacount)            
select e.account from  excel_upgrade_child e            
left join basicdata..[user] u on e.account=u.account and u.deletetag=1            
where e.onepass=1 and e.intime = @intime and u.userid is not null            
             
declare @temp table            
(            
 tcid int,            
 tcname varchar(100),            
 tuserid int,            
 tinuserid int,            
 toldcid int            
)            
insert into @temp(tcid,tcname,tuserid,tinuserid)            
select c.cid,c.cname,u.userid,e.inuserid from excel_upgrade_child e             
   inner join basicdata..[user] u             
   on e.account=u.account and u.kid=@kid  and u.deletetag=1            
   inner join @newaccount n on e.account=nacount            
   inner join basicdata..[class] c on c.cname=e.cname and c.kid=@kid            
  where e.kid=@kid            
   and e.intime = @intime            
   and c.cid is not null            
   and c.kid=@kid            
   and c.deletetag=1            
--更新旧的班级            
update   t set t.toldcid=c.cid from @temp t  left join basicdata..user_class c on c.userid=t.tuserid where c.userid is not null            
--更新新班级            
update   c set c.cid=t.tcid from @temp t  left join basicdata..user_class c on c.userid=t.tuserid where c.userid is not null            
--写日志oldcid：调班之前的班级，cid调班后的班级,operateuserid操作调班的人的ID            
insert into basicdata..user_class_changehistory(cid,oldcid,userid,operateuserid,createdatetime)            
select tcid,toldcid,tuserid,tinuserid,GETDATE() from @temp  where tcid<>toldcid     
       
----记录调班后的班级,存在则修改            
--update ca set ca.term= @term,ca.cid=tcid,actiondate=GETDATE() from @temp left join basicdata..user_class_all ca            
--on tuserid=ca.userid where ca.userid is not null   and tcid<>toldcid   and ca.term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)    
            
--insert into basicdata..user_class_all([cid],[userid],[term],[actiondate],[deletetag])            
--select tcid,tuserid, @term,GETDATE(),1 from @temp left join basicdata..user_class_all ca            
--on tuserid=ca.userid where ca.userid is null     and tcid<>toldcid          
 --记录调班后的班级,存在则修改      
if exists( select * from @temp)
begin
	set @term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)  
   --记录调班后的班级,存在则修改    
   update ca set ca.cid=t.tcid from @temp t inner join basicdata..user_class_all ca on t.tuserid=ca.userid and ca.term=@term and ca.deletetag=1  where  ca.term=@term and ca.deletetag=1 
   and ca.cid is not null
   
    
   if Exists( select * from @temp t left join basicdata..user_class_all ca on t.tuserid=ca.userid  where  ca.term=@term and ca.deletetag=1
   and ca.cid is  null ) 
   insert into basicdata..user_class_all([cid],[userid],[term],[actiondate],[deletetag])     
     select tcid,tuserid, @term,GETDATE(),1 from @temp t left join basicdata..user_class_all ca on t.tuserid=ca.userid  where  ca.term=@term and ca.deletetag=1 
   and ca.cid is  null
   end
            
commit tran            
end try            
begin catch            
 rollback tran             
 SELECT ERROR_NUMBER() as ErrorNumber,            
        ERROR_MESSAGE() as ErrorMessage;            
end catch 
GO
