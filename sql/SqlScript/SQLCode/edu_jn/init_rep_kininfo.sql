USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_kininfo]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_rep_kininfo]
as
delete rep_kininfo

INSERT INTO rep_kininfo
 (kid ,kname ,opentype,citytype ,Kintype,gradeid,gradename
 ,cid,cname,uid,uname,usertype ,birthday,nation,gender,areaid,areaname
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.kid ,m.kname ,n.opentype,n.citytype ,n.Kintype,m.gradeid,m.gradename,m.cid,m.cname
,r.userid,r.name,usertype ,r.birthday,r.nation,r.gender
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) areaname
,r.privince,r.city,r.residence,'','','','','','','',r.mobile
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_class u on u.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
where r.usertype=0  and r.deletetag=1


INSERT INTO rep_kininfo
 (kid ,kname ,opentype,citytype ,Kintype,gradeid,gradename
 ,cid,cname,uid,uname,usertype ,birthday,nation,gender,areaid,areaname
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)


select m.kid ,m.kname ,n.opentype,n.citytype ,n.Kintype,max(m.gradeid),max(m.gradename),max(m.cid),max(m.cname),
r.userid,r.name,isnull(kwebcms.usertype,1) ,r.birthday,r.nation,r.gender,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) areaname
,r.privince,r.city,r.residence,t.education,t.title,t.post,t.politicalface,max(t.did)
,t.employmentform,t.kinschooltag,max(r.mobile)
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
left join BasicData..user_class uc on uc.cid=m.cid 
inner join BasicData..[user] r on r.kid=n.kid 
left join BasicData..teacher t on t.userid=r.userid 
outer apply
(select top 1 (CASE lx.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1  end) usertype 
	from KWebCMS..site_user su
		inner join KWebCMS_Right.dbo.sac_user ux on ux.user_id = su.UID
		inner join KWebCMS_Right.dbo.sac_user_role rx on rx.user_id = ux.user_id
		inner join KWebCMS_Right.dbo.sac_role lx on lx.role_id=rx.role_id
	where su.appuserid = r.userid
	order by (CASE lx.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1 end) asc
) kwebcms

where r.usertype>0 and r.deletetag=1 
group by  m.kid ,m.kname ,opentype,citytype ,Kintype
,r.userid,r.name,r.birthday,r.nation,r.gender
,m.areaid,r.privince,r.city,r.residence,t.education,t.title,t.post,t.politicalface,t.employmentform,t.kinschooltag
,kwebcms.usertype



GO
