


alter PROCEDURE [dbo].[init_lxq]
as

--同步删除幼儿园
delete g from gartenlist g
		inner join Area a
			 on a.ID=g.areaid
		left join BasicData..kindergarten k
			on k.kid=g.kid and k.deletetag=1
		where (a.ID =722 or a.Superior=722)
		and k.kid is null


--同步删除幼儿园

update g
	set g.kname=k.kname,
		g.opentype=k.opentype,
		g.citytype=k.citytype,
		g.kintype=k.kintype,
		g.mastername=k.mastername, 
		g.sitedns=ki.netaddress
	from gartenlist g
	inner join BasicData..kindergarten k
		on k.kid=g.kid
	inner join ossapp..kinbaseinfo ki 
		on ki.kid=g.kid
	where k.area=722



insert into gartenlist(kid,kname,sitedns,mingyuan,orderby,areaid,regdatetime,actiondate,telephone,qq,opentype,citytype,kintype,mastername,[address])
select k.kid,k.kname,s.sitedns,'',0,[dbo].[GetKinArea](k.privince,k.city,k.area,k.residence)
,k.actiondate,k.actiondate,k.telephone,k.qq,k.opentype,k.citytype,k.kintype,k.mastername,k.[address] 
		from BasicData..kindergarten k
			left join kwebcms..[site] s 
				on s.siteid=kid 
			left join gartenlist g
				on g.kid=k.kid
		where k.area=722 
			  and g.kid is null
				
--初始化部门department
delete department

insert into department(did,dname,superior,[order],deletetag,kid,actiondatetime)
select distinct did,dname,superior,[order],deletetag,d.kid,actiondatetime
from basicdata..department d
inner join gartenlist g on d.kid=g.kid


delete r from 
rep_classinfo r
inner join Area a on a.ID=r.areaid
where a.Superior=722

insert into rep_classinfo(kid,kname,gradeid,gradename,cid,cname,areaid)
select n.kid,n.kname,g.gid,g.gname,c.cid,c.cname,m.areaid from gartenlist m
left join BasicData..kindergarten n on n.kid=m.kid
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1
left join BasicData..grade g on g.gid=c.grade 
inner join Area a on a.ID=m.areaid
where a.Superior=722

delete r from 
[rep_kininfo] r
inner join Area a on a.ID=r.areaid
where a.Superior=722 

INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename],m.[cid],[cname]
,b.userid,b.[name],[usertype] ,b.[birthday],b.[nation],b.gender
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,179,180,722,'','','','','','','',b.mobile
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_class u on u.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
inner join BasicData..user_baseinfo b on b.userid=u.userid 
inner join Area a on a.ID=m.areaid
where [usertype]=0  and r.deletetag=1 and a.Superior=722


INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],max([gradeid]),max([gradename]),max(m.[cid]),max([cname])
,b.userid,b.[name],[usertype] ,b.[birthday],b.[nation],b.[gender]
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,179,180,722,t.education,t.title,t.post,t.politicalface,max(t.did)
,employmentform,kinschooltag,max(b.mobile)
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_kindergarten u on u.kid=m.kid 
left join BasicData..user_class uc on uc.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
inner join BasicData..user_baseinfo b on b.userid=u.userid 
left join BasicData..teacher t on t.userid=u.userid 
inner join Area a on a.ID=m.areaid
where [usertype]>0 and [usertype]<98 and r.deletetag=1  and a.Superior=722
group by  m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype]
,b.userid,b.[name],[usertype] ,b.[birthday],b.[nation],b.[gender]
,m.areaid,b.privince,b.city,b.residence,t.education,t.title,t.post,t.politicalface,t.employmentform,t.kinschooltag



------------------------------------------园所报道-------------------------------------
delete c from cms_content c
	inner join gartenlist g
		on c.siteid = g.kid   
	inner join area a   
		on a.ID = g.areaid
	left join dbo.ActicleState acs
		on acs.contentid=c.contentid   
	where c.categoryid=17095 
	and acs.ishow is not null
	and c.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！'
	and (722 = a.Superior  or a.ID=722)
	and c.contentid<2147483647

;with
cet
as(
	select c.[contentid],c.[categoryid],c.[content] content,c.[title],c.[titlecolor],c.[author],
				c.[createdatetime],c.[searchkey],c.[searchdescription],c.[browsertitle],
				c.[viewcount],c.[commentcount],-1 [orderno],c.[commentstatus],c.[ispageing],
				c.[status],c.[siteid]
	 from dbo.gartenlist g   
	  inner join KWebCMS..cms_content c  
	   on c.siteid = g.kid   
	  inner join area a   
	   on a.ID = g.areaid  
	  left join dbo.ActicleState acs
	   on acs.contentid=c.contentid
	  left join cms_content cc
		on cc.contentid=c.contentid
	 where c.categoryid=17095 
		and (acs.ishow is not null or cc.contentid is null)
		and c.title <> '幼儿园网站开通啦！欢迎家长们上网浏览！'
		and (722 = a.Superior  or a.ID=722)
)

insert into cms_content  
select  * from cet


insert into ActicleState(contentid, ishow, uid, uptime)  
SELECT c.contentid,1,0,GETDATE() 
	from cms_content c
		left join ActicleState a 
			on a.contentid=c.contentid
		where orderno=-1 and a.contentid is null

update cms_content set orderno=0 
	where orderno=-1 
	
------------------------------------------园所报道-------------------------------------


------------------------------------------博客信息-------------------------------------



delete b from [bloglist] b
inner join Area a	
	on a.ID=b.areaid
	where a.Superior=722 or a.ID=722



INSERT INTO [dbo].[bloglist]
           ([postid]
           ,[userid]
           ,[title]
           ,[author]
           ,[kname]
           ,[sitedns]
           ,[postdatetime],usertype,[areaid])    
	
select  t4.postid,t4.userid,t4.title,t4.author,t1.kname,t1.sitedns,
t4.postdatetime,t3.usertype,t1.areaid
	from dbo.gartenlist t1
inner join kwebcms..blog_posts t6 on t1.kid=t6.siteid	
inner join BlogApp..blog_posts t4 on t6.postid=t4.postid
inner join basicdata..user_bloguser t2 on t2.bloguserid=t4.userid
inner join basicdata..[user] t3 on t2.userid=t3.userid
inner join Area a on a.ID=t1.areaid
	WHERE t4.title not in ('我的教学助手开通啦','我的成长档案开通啦')
	and t4.deletetag=1 and t3.deletetag=1 
	and (a.Superior=722 or a.ID=722)
	order by t4.postid desc 



insert into KinInfoApp..kindergarten_condition(kid,kname,kurl,isgood)
select kid,kname,sitedns,0 from edu_jn..gartenlist g where  not exists (
select kid from KinInfoApp..kindergarten_condition c where c.kid=g.kid
)

------------------------------------------博客信息-------------------------------------

update dbo.config_manage set syn=1 where appname in ('历下前台','历下后台')
GO




