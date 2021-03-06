USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_t_child_vipoldGetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [kmp_t_child_vipoldGetList] 2395,9343,'2009-01-01','2010-03-01',1

CREATE PROCEDURE [dbo].[kmp_t_child_vipoldGetList]
@siteid int,
@classid int,
@enddate_s datetime,
@enddate_e datetime,
@iscurrent int
AS
BEGIN	
	if(@classid>0)
	begin
		select t2.cname as classname, c.userid, c.name,t7.vipstatus,t2.cid,c.deletetag as status,t1.startdate,t1.enddate,t1.iscurrent
		 From zgyey_om..vipdetails t1 
		 left join basicdata..[user] c on c.userid=t1.userid
		left join basicdata..user_class t3 on t3.userid=c.userid
		left join basicdata..child t7 on t7.userid=c.userid
		left join basicdata..class t2 on t3.cid=t2.cid
		where t2.kid=@siteid and c.deletetag=1 and t2.cid=@classid and t1.enddate between @enddate_s and @enddate_e
			and t1.iscurrent=@iscurrent
		order by c.userid ,t2.cid
	end
	else
	begin
		select t2.cname as classname, c.userid, c.name,t7.vipstatus,t2.cid,c.deletetag as status,t1.startdate,t1.enddate,t1.iscurrent
		 From zgyey_om..vipdetails t1 
		 left join basicdata..[user] c on c.userid=t1.userid
		left join basicdata..user_class t3 on t3.userid=c.userid
		left join basicdata..child t7 on t7.userid=c.userid
		left join basicdata..class t2 on t3.cid=t2.cid
		where t2.kid=@siteid and c.deletetag=1 and t1.enddate between @enddate_s and @enddate_e
			and t1.iscurrent=@iscurrent
		order by c.userid ,t2.cid
	end

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_vipoldGetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_vipoldGetList', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
