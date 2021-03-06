USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_rep_kininfo]    Script Date: 08/10/2013 10:23:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[pro_init_rep_kininfo]
as


delete [rep_kininfo]

INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename],m.[cid],[cname]
,r.userid,r.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,r.privince,r.city,r.residence,'','','','','','','',mobile
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_class u on u.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
where [usertype]=0  and r.deletetag=1


INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],max([gradeid]),max([gradename]),max(m.[cid]),max([cname])
,u.userid,u.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,u.privince,u.city,u.residence,t.education,t.title,t.post,t.politicalface,max(t.did)
,employmentform,kinschooltag,max(mobile)
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..[user] u on u.kid=m.kid 
left join BasicData..user_class uc on uc.cid=m.cid  
left join BasicData..teacher t on t.userid=u.userid 
where [usertype]>0 and u.deletetag=1 
group by  m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype]
,u.userid,u.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,u.privince,u.city,u.residence,t.education,t.title,t.post,t.politicalface,t.employmentform,t.kinschooltag
GO
