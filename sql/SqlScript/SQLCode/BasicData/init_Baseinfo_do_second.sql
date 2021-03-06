USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_Baseinfo_do_second]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--只初始化usertype <> 98的用户数据
CREATE PROCEDURE [dbo].[init_Baseinfo_do_second]
@privince int,
@city int,
@residence int
as

declare @ncid int,@nkid int,@ndid int
select @ncid=ncid,@nkid=nkid,@ndid=ndid from BasicData..init_Baseinfo where ncid is not null and nkid is not null

--班级关系
delete from BasicData..user_class where 
userid in (select u.userid from BasicData..user_kindergarten k 
inner join BasicData..[user] u on k.userid=u.userid where k.kid=@nkid and u.usertype<>98)

insert into BasicData..user_class
select case when ncid is null then @ncid else ncid end,nuid from BasicData..init_Baseinfo





--基本表
delete from BasicData..user_baseinfo where 
userid in (select u.userid from BasicData..user_kindergarten k 
inner join BasicData..[user] u on k.userid=u.userid where k.kid=@nkid and u.usertype<>98)

insert into BasicData..user_baseinfo
select nuid,[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],[exigencetelphone],[headpicupdate],[headpic],@privince,@city,[istip],@residence from BasicData..init_Baseinfo i
inner join BasicData..user_baseinfo u on i.uid=u.userid

--小朋友表
delete from BasicData..child where 
userid in (select u.userid from BasicData..user_kindergarten k 
inner join BasicData..[user] u on k.userid=u.userid where k.kid=@nkid and u.usertype<>98)

insert into BasicData..child
select nuid,[fathername],[mothername],[favouritething],[fearthing],[favouritefoot],[footdrugallergic],[vipstatus] from BasicData..init_Baseinfo i
inner join BasicData..child u on i.uid=u.userid

--教师表
delete from BasicData..teacher where 
userid in (select u.userid from BasicData..user_kindergarten k 
inner join BasicData..[user] u on k.userid=u.userid where k.kid=@nkid and u.usertype<>98)

insert into BasicData..teacher
select nuid,case when ndid is null then @ndid else ndid end,[title],[post],[education],[employmentform],[politicalface],1 from BasicData..init_Baseinfo i
inner join BasicData..teacher u on i.uid=u.userid
GO
