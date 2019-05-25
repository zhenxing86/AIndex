USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Child_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[Child_GetModel] 
@userid int
as 

select 
u.uid,[uname],birthday
,case when gender=2 then '女' else '男' end sex
,nation,u_mobile, email, address
,(select title from BasicData..Area where ID=u_privince) privince
,(select title from BasicData..Area where ID=u_city) city
,istip
,(select title from BasicData..Area where ID=u_residence) residence
,exigencetelphone,fathername,mothername,favouritething,fearthing,favouritefoot,footdrugallergic,vipstatus

 from dbo.rep_kininfo u 
left join child  c on c.userid=u.uid
where u.uid=@userid

GO
