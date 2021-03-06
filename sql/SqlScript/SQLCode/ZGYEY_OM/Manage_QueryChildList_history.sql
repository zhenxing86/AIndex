USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_QueryChildList_history]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Manage_QueryChildList_history] '20040921','','13682238844',1
CREATE PROCEDURE [dbo].[Manage_QueryChildList_history] 
@loginname nvarchar(30),
@name nvarchar(30),
@mobile nvarchar(20),
@querytype int
AS
if(@querytype=1)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t5.kid,t5.actiondatetime
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.user_kindergarten_history t5 on t1.userid=t5.userid 
	inner join basicdata.dbo.kindergarten t6 on t5.kid=t6.kid
	Inner JOIN  basicdata.dbo.user_class_history t2 on t1.userid=t2.userid 
	inner join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE --t1.usertype=0 and 
	t1.account=@loginname
end
else if(@querytype=2)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t5.kid,t5.actiondatetime
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.user_kindergarten_history t5 on t1.userid=t5.userid 
	inner join basicdata.dbo.kindergarten t6 on t5.kid=t6.kid
	Inner JOIN  basicdata.dbo.user_class_history t2 on t1.userid=t2.userid 
	inner join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE --t1.usertype=0 and 
	t1.name=@name
end
else if(@querytype=3)
begin
	SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t5.kid,t5.actiondatetime
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.user_kindergarten_history t5 on t1.userid=t5.userid 
	inner join basicdata.dbo.kindergarten t6 on t5.kid=t6.kid
	Inner JOIN  basicdata.dbo.user_class_history t2 on t1.userid=t2.userid 
	inner join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE --t1.usertype=0 and 
	t1.mobile=@mobile
end

GO
