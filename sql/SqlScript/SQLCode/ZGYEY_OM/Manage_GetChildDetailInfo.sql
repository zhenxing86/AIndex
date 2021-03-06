USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetChildDetailInfo]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [Manage_GetChildDetailInfo] 295765 
CREATE PROCEDURE [dbo].[Manage_GetChildDetailInfo]
@userid int
AS
SELECT  t6.kname, t4.cname,t1.name,case t1.gender when 2 then '女' when 3 then '男' end,t1.account,t1.mobile,t1.enrollmentdate,t1.birthday,t1.userid,t2.cid,t1.kid
	FROM basicdata.dbo.[user] t1 
	inner join basicdata.dbo.kindergarten t6 on t1.kid=t6.kid
	Inner JOIN  basicdata.dbo.user_class t2 on t1.userid=t2.userid 
	inner join basicdata.dbo.class t4 on t2.cid=t4.cid 
	WHERE t1.userid=@userid

GO
