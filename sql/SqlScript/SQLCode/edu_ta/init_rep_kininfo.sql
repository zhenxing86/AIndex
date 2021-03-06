USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_kininfo]    Script Date: 08/10/2013 10:11:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [rep_kininfo] where kid=14331 and usertype=1

--select * from [rep_kininfo]

CREATE PROCEDURE [dbo].[init_rep_kininfo]
as


delete [rep_kininfo]

INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename],m.[cid],[cname]
,b.userid,b.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,b.privince,b.city,b.residence,'','','','','','','',mobile
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_class u on u.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
inner join BasicData..user_baseinfo b on b.userid=u.userid 
where [usertype]=0  and r.deletetag=1


INSERT INTO [rep_kininfo]
 ([kid] ,[kname] ,[opentype],[citytype] ,[Kintype],[gradeid],[gradename]
 ,[cid],[cname],[uid],[uname],[usertype] ,[birthday],[nation],[gender],[areaid],[areaname]
,u_privince,u_city,u_residence,t_education,t_title,t_post,t_politicalface,t_did,t_employmentform,t_kinschooltag,u_mobile
)
select m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype],max([gradeid]),max([gradename]),max(m.[cid]),max([cname])
,b.userid,b.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,(select  Title from BasicData..Area a where a.ID=m.areaid) [areaname]
,b.privince,b.city,b.residence,t.education,t.title,t.post,t.politicalface,max(t.did)
,employmentform,kinschooltag,max(mobile)
 from rep_classinfo m 
inner join BasicData..kindergarten n on n.kid=m.kid
inner join BasicData..user_kindergarten u on u.kid=m.kid 
left join BasicData..user_class uc on uc.cid=m.cid 
inner join BasicData..[user] r on r.userid=u.userid 
inner join BasicData..user_baseinfo b on b.userid=u.userid 
left join BasicData..teacher t on t.userid=u.userid 
where [usertype]>0 and r.deletetag=1 
group by  m.[kid] ,m.[kname] ,[opentype],[citytype] ,[Kintype]
,b.userid,b.[name],[usertype] ,[birthday],[nation],[gender]
,m.areaid,b.privince,b.city,b.residence,t.education,t.title,t.post,t.politicalface,t.employmentform,t.kinschooltag
GO
