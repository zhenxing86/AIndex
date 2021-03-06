USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_QueryChildList_Main]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Manage_QueryChildList_Main] 'along','$$$','$$$',1
CREATE PROCEDURE [dbo].[Manage_QueryChildList_Main] 
@loginname nvarchar(30),
@name nvarchar(30),
@mobile nvarchar(20),
@cuid int
AS

declare @usertype int,@roleid int,@bid int,@duty varchar(20)
select @usertype=usertype,@roleid=roleid,@bid=bid,@duty=duty from ossapp..users u
inner join ossapp..[role] r on u.roleid=r.ID
 where u.ID=@cuid


create table #ulist
(puid int)


insert into #ulist(puid) values (@cuid)

insert into #ulist(puid)
select ID from ossapp..users where seruid=@cuid

insert into #ulist(puid)
select cuid from ossapp..users_belong where puid=@cuid


if(@bid=0 and @duty='客服部')
begin

	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1  
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	inner join ossapp..kinbaseinfo ki on ki.kid=t6.kid
	WHERE 
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')


end
--总部非客服部（市场部）：可以看到自己开发的客户
else if(@bid=0 and @duty<>'客服部')
begin

	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	inner join ossapp..kinbaseinfo ki on ki.kid=t6.kid
	WHERE 
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')
	and developer = @cuid


end
--代理商客服部：可以看到所有代理商的客户
else if(@bid>0 and @duty='客服部')
begin
	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	inner join ossapp..kinbaseinfo ki on ki.kid=t6.kid
	WHERE 
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')
and abid=@bid and infofrom='代理'


end
--代理商经理：可以看到所有代理商的客户
else if(@bid>0 and @usertype=0)
begin

	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	inner join ossapp..kinbaseinfo ki on ki.kid=t6.kid
	WHERE 
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')
and abid=@bid and infofrom='代理'



end
--其他属于代理商市场部：可以看到所有代理商的自己发展人的客户
else 
begin

	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	inner join ossapp..kinbaseinfo ki on ki.kid=t6.kid
	WHERE 
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')
and developer = @cuid
--and abid=@bid 
and infofrom='代理'


end


drop table #ulist

GO
