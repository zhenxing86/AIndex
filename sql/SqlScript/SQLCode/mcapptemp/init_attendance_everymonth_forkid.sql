USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[init_attendance_everymonth_forkid]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-05-08  
-- Description: 重新生成某个幼儿园某段时间的考勤报表
-- Memo:  
EXEC mcapp..init_attendance_everymonth_forkid 19481,'2013-09-01','2013-09-29'
*/ 
CREATE PROCEDURE [dbo].[init_attendance_everymonth_forkid]
 @kid int,
 @bgndate datetime,
 @enddate datetime
AS
BEGIN
	SET NOCOUNT ON
 

		SELECT c.userid, t.did as deptid, 1 as usertype, ta.cdate
		into #cet
			FROM mcapp.dbo.tea_at_day ta 				 
				inner join mcapp..cardinfo c
					on ta.card = c.cardno
				inner join BasicData.dbo.teacher t  
					on c.userid = t.userid  
				WHERE ta.kid = @kid
					and ta.cdate >= @bgndate
					and ta.cdate <= dateadd(dd,1,@enddate)
		union
		SELECT c.userid, t.did as deptid, 1 as usertype, ta.cdate
			FROM mcapp.dbo.tea_at_month ta 
				inner join mcapp..cardinfo c
					on ta.card = c.cardno
				inner join BasicData.dbo.teacher t  
					on c.userid = t.userid  
				WHERE ta.kid = @kid
					and ta.cdate >= @bgndate
					and ta.cdate <= dateadd(dd,1,@enddate)
		union
		SELECT ta.stuid as userid, 0 as deptid, 0 as usertype, ta.cdate
			FROM mcapp.dbo.stu_at_day ta
			where ta.kid = @kid
				and ta.cdate >= @bgndate
				and ta.cdate <= dateadd(dd,1,@enddate) 
		union
		SELECT ta.stuid as userid, 0 as deptid, 0 as usertype, ta.cdate
			FROM mcapp.dbo.stu_at_month ta
			where ta.kid = @kid
				and ta.cdate >= @bgndate
				and ta.cdate <= dateadd(dd,1,@enddate) 
		union
		SELECT ta.[UserID] , CASE WHEN ta.UserType = 0 then 0 else t.did end as deptid, ta.UserType, ta.CheckTime
			FROM [CardApp].[dbo].[attendance]	ta 
				LEFT join BasicData.dbo.teacher t
					on ta.[UserID] = t.userid
				where ta.kid = @kid
					and ta.CheckTime >= @bgndate
					and ta.CheckTime <= dateadd(dd,1,@enddate)
		union
		SELECT ta.[UserID] , CASE WHEN ta.UserType = 0 then 0 else t.did end as deptid, ta.UserType, ta.CheckTime
			FROM [CardApp].[dbo].attendance_history	ta 
				LEFT join BasicData.dbo.teacher t
					on ta.[UserID] = t.userid
				where ta.kid = @kid
					and ta.CheckTime >= @bgndate
					and ta.CheckTime <= dateadd(dd,1,@enddate)
		order by userid, cdate		

	select DISTINCT [UserID] , deptid, UserType,YEAR(c.cdate) year, MONTH(c.cdate) month, DAY(c.cdate)DAY	, 
	STUFF(Commonfun.dbo.sp_GetSumStr(DISTINCT '<br /> ' + RIGHT(CONVERT(VARCHAR(16),c.cdate,120),5)),1,6,'') as sumstr
		into #cet0
				FROM #CET c
	GROUP BY c.userid, c.deptid,  c.usertype, 
					YEAR(c.cdate), MONTH(c.cdate), DAY(c.cdate)	

		SELECT u.kid, c.userid, c.deptid, CAST(0 AS INT) classid, c.usertype,
					 year,  month, day, sumstr									
		into #cet1
			FROM #cet0 c
				inner join BasicData.dbo.[user] u 
					on c.userid = u.userid	
					
	update #cet1 set classid = uc.cid 
		from #cet1 c 
			inner join BasicData..User_Child uc 
			on c.userid = uc.userid
				     
	select * 
		INTO #T 
		FROM #CET1 pivot(max(sumstr) 
				for day in(	[1] ,[2] ,[3] ,[4] ,[5] ,[6] ,[7] ,[8] ,[9] ,[10],
										[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
										[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])) as p    
	 
	INSERT INTO  [CardApp].[dbo].[attendance_everymonth]
			([kid], [userid], [deptid], [classid], [usertype], [year], [month]) 
	SELECT [kid], [userid], [deptid], [classid], [usertype], [year], [month]
		FROM #T t 
			WHERE NOT EXISTS(
											select 1 from [CardApp].[dbo].[attendance_everymonth] ae 
												where t.userid = ae.userid 
													and t.year = ae.year 
													and t.month = ae.month
											)
 SET ANSI_WARNINGS OFF   		
	update [CardApp].[dbo].[attendance_everymonth]
	set    kid = t.kid
				,classid = t.classid
				,[day_1]  = ISNULL(t.[1] ,ae.[day_1])
				,[day_2]  = ISNULL(t.[2] ,ae.[day_2])
				,[day_3]  = ISNULL(t.[3] ,ae.[day_3])
				,[day_4]  = ISNULL(t.[4] ,ae.[day_4])
				,[day_5]  = ISNULL(t.[5] ,ae.[day_5])
				,[day_6]  = ISNULL(t.[6] ,ae.[day_6])
				,[day_7]  = ISNULL(t.[7] ,ae.[day_7])
				,[day_8]  = ISNULL(t.[8] ,ae.[day_8])
				,[day_9]  = ISNULL(t.[9] ,ae.[day_9])
				,[day_10] = ISNULL(t.[10],ae.[day_10])
				,[day_11] = ISNULL(t.[11],ae.[day_11])
				,[day_12] = ISNULL(t.[12],ae.[day_12])
				,[day_13] = ISNULL(t.[13],ae.[day_13])
				,[day_14] = ISNULL(t.[14],ae.[day_14])
				,[day_15] = ISNULL(t.[15],ae.[day_15])
				,[day_16] = ISNULL(t.[16],ae.[day_16])
				,[day_17] = ISNULL(t.[17],ae.[day_17])
				,[day_18] = ISNULL(t.[18],ae.[day_18])
				,[day_19] = ISNULL(t.[19],ae.[day_19])
				,[day_20] = ISNULL(t.[20],ae.[day_20])
				,[day_21] = ISNULL(t.[21],ae.[day_21])
				,[day_22] = ISNULL(t.[22],ae.[day_22])
				,[day_23] = ISNULL(t.[23],ae.[day_23])
				,[day_24] = ISNULL(t.[24],ae.[day_24])
				,[day_25] = ISNULL(t.[25],ae.[day_25])
				,[day_26] = ISNULL(t.[26],ae.[day_26])
				,[day_27] = ISNULL(t.[27],ae.[day_27])
				,[day_28] = ISNULL(t.[28],ae.[day_28])
				,[day_29] = ISNULL(t.[29],ae.[day_29])
				,[day_30] = ISNULL(t.[30],ae.[day_30])
				,[day_31] = ISNULL(t.[31],ae.[day_31]) 
		from [CardApp].[dbo].[attendance_everymonth] ae 
			inner join #T t 
				on  t.userid = ae.userid 
				and t.year = ae.year 
				and t.month = ae.month
 SET ANSI_WARNINGS ON 
	update [CardApp].[dbo].[attendance_everymonth]
	set    [days]  = 
		CASE WHEN ae.[day_1] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_2] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_3] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_4] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_5] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_6] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_7] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_8] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_9] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_10] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_11] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_12] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_13] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_14] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_15] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_16] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_17] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_18] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_19] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_20] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_21] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_22] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_23] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_24] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_25] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_26] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_27] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_28] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_29] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_30] IS NULL THEN 0 ELSE 1 END + 
		CASE WHEN ae.[day_31] IS NULL THEN 0 ELSE 1 END  
		from [CardApp].[dbo].[attendance_everymonth] ae 
			inner join #T t 
				on  t.userid = ae.userid 
				and t.year = ae.year 
				and t.month = ae.month
--select * from #T
	drop table #T

END

GO
