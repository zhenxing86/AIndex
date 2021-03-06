USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[init_fcq]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_fcq]  
as  
  
--同步删除幼儿园  
delete g from gartenlist g  
  inner join Area a  
    on a.ID=g.areaid  
  left join BasicData..kindergarten k  
   on k.kid=g.kid and k.deletetag=1  
  where (a.ID =737 or a.Superior=737)  
  and k.kid is null  
  
  
--同步删除幼儿园  
  
update g  
 set g.kname=k.kname,  
  g.sitedns=ki.netaddress  
 from gartenlist g  
 inner join BasicData..kindergarten k  
  on k.kid=g.kid  
 inner join ossapp..kinbaseinfo ki   
  on ki.kid=g.kid  
 where k.area=737  
  
  
  
insert into gartenlist(kid,kname,sitedns,mingyuan,orderby,areaid,regdatetime)  
select k.kid,k.kname,s.sitedns,'',0,[dbo].[GetKinArea](k.privince,k.city,k.area,k.residence)  
,k.actiondate   
  from BasicData..kindergarten k  
   left join kwebcms..[site] s   
    on s.siteid=kid   
   left join gartenlist g  
    on g.kid=k.kid  
  where k.area=737   
     and g.kid is null   
     and k.deletetag=1  
      
      
delete r from   
rep_classinfo r  
inner join Area a on a.ID=r.areaid  
where a.Superior=737  
  
insert into rep_classinfo(kid,kname,gradeid,gradename,cid,cname,areaid)  
select n.kid,n.kname,g.gid,g.gname,c.cid,c.cname,m.areaid from gartenlist m  
left join BasicData..kindergarten n on n.kid=m.kid  
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1  
left join BasicData..grade g on g.gid=c.grade   
inner join Area a on a.ID=m.areaid  
where a.Superior=737  
  
delete r from   
[rep_kininfo] r  
inner join Area a on a.ID=r.areaid  
where a.Superior=737   
  
INSERT INTO [rep_kininfo]  
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]  
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]  
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile  
)  
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename],m.[cid],[cname]  
,b.userid,b.[name],[usertype] ,b.[birthday],b.[nation],b.gender  
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]  
,179,180,737,'','','','','','','',b.mobile  
 from rep_classinfo m   
inner join BasicData..kindergarten n on n.kid=m.kid  
inner join BasicData..user_class u on u.cid=m.cid   
inner join BasicData..[user] r on r.userid=u.userid   
inner join BasicData..user_baseinfo b on b.userid=u.userid   
inner join Area a on a.ID=m.areaid  
where [usertype]=0  and r.deletetag=1 and a.Superior=737  
  
  
INSERT INTO [rep_kininfo]  
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]  
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]  
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile  
)  
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],max([gradeid]),max([gradename]),max(m.[cid]),max([cname])  
,b.userid,b.[name],ISNULL(kwebcms.usertype,1) ,b.[birthday],b.[nation],b.[gender]  
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]  
,179,180,737,t.education,t.title,t.post,t.politicalface,max(t.did)  
,employmentform,kinschooltag,max(b.mobile)  
 from rep_classinfo m   
inner join BasicData..kindergarten n on n.kid=m.kid  
inner join BasicData..user_kindergarten u on u.kid=m.kid   
left join BasicData..user_class uc on uc.cid=m.cid   
inner join BasicData..[user] r on r.userid=u.userid   
inner join BasicData..user_baseinfo b on b.userid=u.userid   
left join BasicData..teacher t on t.userid=u.userid   
inner join Area a on a.ID=m.areaid  
outer apply
(select top 1 (CASE lx.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1  end) usertype 
	from KWebCMS..site_user su
		inner join KWebCMS_Right.dbo.sac_user ux on ux.user_id = su.UID
		inner join KWebCMS_Right.dbo.sac_user_role rx on rx.user_id = ux.user_id
		inner join KWebCMS_Right.dbo.sac_role lx on lx.role_id=rx.role_id
	where su.appuserid = r.userid
	order by (CASE lx.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1 end) asc
) kwebcms

where r.[usertype]>0 and r.[usertype]<98 and r.deletetag=1  and a.Superior=737  
group by  m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype]  
,b.userid,b.[name],kwebcms.[usertype] ,b.[birthday],b.[nation],b.[gender]  
,m.areaid,b.privince,b.city,b.residence,t.education,t.title,t.post,t.politicalface,t.employmentform,t.kinschooltag  
  
  
  
------------------------------------------园所报道-------------------------------------  

------------------------------------------园所报道-------------------------------------  
  
  
------------------------------------------博客信息-------------------------------------  
  
  
  
delete b from [bloglist] b  
inner join Area a   
 on a.ID=b.areaid  
 where a.Superior=737 or a.ID=737  
  
  
  
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
 and (a.Superior=737 or a.ID=737)  
 order by t4.postid desc   
  
  
  
insert into KinInfoApp..kindergarten_condition(kid,kname,kurl,isgood)  
select kid,kname,sitedns,0 from edu_jn..gartenlist g where  not exists (  
select kid from KinInfoApp..kindergarten_condition c where c.kid=g.kid  
)  
  
------------------------------------------博客信息-------------------------------------  
  
GO
