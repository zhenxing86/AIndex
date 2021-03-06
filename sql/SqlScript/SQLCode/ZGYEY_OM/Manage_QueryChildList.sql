USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_QueryChildList]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Manage_QueryChildList] 'along','','13682238844',3
CREATE PROCEDURE [dbo].[Manage_QueryChildList] 
@loginname nvarchar(30),
@name nvarchar(30),
@mobile nvarchar(20),
@querytype int
AS
if(@querytype=1)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE  --t4.iscurrent=1 and t4.deletetag=1 and 
	t1.deletetag=1
	and t1.account=@loginname
end
else if(@querytype=2)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE --t1.usertype=0 and  t4.iscurrent=1 and t4.deletetag=1 and 
	t1.deletetag=1
and t1.name=@name
end
else if(@querytype=3)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE --t1.usertype=0 and t4.iscurrent=1 and t4.deletetag=1 and 
	t1.deletetag=1
	and t1.mobile=@mobile
end

else if(@querytype=-1)
begin
	SELECT  t6.kname, t4.cname,t1.[name],case t1.gender when 2 then '女' when 3 then '男' end sex,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid,t1.deletetag,(case when t7.vipstatus is null then 2 else t7.vipstatus end ) vipstatus
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	left JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	left join basicdata.dbo.class t4 on t2.cid=t4.cid 
	left join basicdata.dbo.child t7 on t7.userid=t1.userid
	WHERE --t1.usertype=0 and t4.iscurrent=1 and t4.deletetag=1 and t1.deletetag=1
	(t1.mobile=@mobile or @mobile ='$$$')
	and (t1.[name]=@name or @name ='$$$')
	and (t1.account=@loginname or @loginname ='$$$')
end



GO
