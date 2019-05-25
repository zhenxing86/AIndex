USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_Set]    Script Date: 03/03/2014 16:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dataimport_Set]
@kid int,
@usertype int,
@intime datetime='1900-1-1'
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
			
--如果导入的资料就有重复
update excel_input_child set onepass=0,nopass=1
where account in 
(select account
 from excel_input_child e
where kid=@kid and intime=@intime
group by account having COUNT(1)>1)

--修正
update e set e.nopass=1 from excel_input_child e 
		where e.kid=@kid
			and intime = @intime
			and e.onepass=0

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

--插入user_class表
insert into basicdata..[user_class]([cid],[userid])  
select tcid,tuserid from @temp
left join basicdata..[user_class] uc on uc.userid=tuserid
where uc.userid is null

--插入user_bloguser表
INSERT INTO basicdata..user_bloguser(userid) 
select tuserid from @temp 
left join basicdata..user_bloguser b on b.userid=tuserid
where b.userid is null


--ChildDetails_Add存储过程，在有的时候更新，在无的时候新增，所以不需要初始化


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
	--默认全部错误
	update excel_input_teacher set onepass=0,nopass=1 
	where kid=@kid and intime = @intime

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
			inner join basicdata..[class] c on c.cname=e.cname and c.kid=@kid
			cross apply (
				select top 1 did,dname,deletetag from basicdata..department dx 
				where dx.dname=e.dname and dx.kid=@kid 
			) d
			where e.kid=@kid
				and d.deletetag=1
				and e.intime = @intime
				and c.deletetag=1
				and c.kid=@kid
				and c.deletetag=1
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
 
commit tran
end try
begin catch
 rollback tran 
 SELECT ERROR_NUMBER() as ErrorNumber,
        ERROR_MESSAGE() as ErrorMessage;
end catch
