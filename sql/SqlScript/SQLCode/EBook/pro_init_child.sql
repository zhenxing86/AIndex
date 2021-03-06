USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_child]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_child]
as

----初始化幼儿园
delete child

insert into child([userid],[fathername],[mothername],[favouritething],[fearthing],[favouritefoot],[footdrugallergic],[vipstatus],[email],[address],[istip],[exigencetelphone])
select c.[userid],[fathername],[mothername],[favouritething]
,[fearthing],[favouritefoot],[footdrugallergic],[vipstatus]
,r.[email],r.[address],r.[istip],r.[exigencetelphone] FROM basicdata..[child] c
inner join basicdata..[user] r on r.userid=c.userid
inner join dbo.gartenlist g on g.kid=r.kid 
where r.deletetag=1 and r.usertype=0

GO
