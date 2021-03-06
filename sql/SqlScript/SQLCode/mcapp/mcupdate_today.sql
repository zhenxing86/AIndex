USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mcupdate_today]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[mcupdate_today]
AS
BEGIN
	SET NOCOUNT ON
	
	select count(sm.stuid)smcnt, u.kid, CAST(CONVERT(VARCHAR(17),sm.adate,120)+'00'  AS DATETIME)adate
	INTO #stu_mc
		from stu_mc_day sm 
			inner join BasicData..[user] u 
				on sm.stuid = u.userid
		where sm.Status = 0
	GROUP BY u.kid, CAST(CONVERT(VARCHAR(17),sm.adate,120)+'00'  AS DATETIME)
	
	select count(sa.stuid)sacnt, u.kid, CAST(CONVERT(VARCHAR(17),sa.adate,120)+'00'  AS DATETIME)adate
	INTO #stu_at
		from stu_at_day sa 
			inner join BasicData..[user] u 
				on sa.stuid = u.userid
	GROUP BY u.kid, CAST(CONVERT(VARCHAR(17),sa.adate,120)+'00'  AS DATETIME)

	select count(ta.teaid)tacnt, u.kid, CAST(CONVERT(VARCHAR(17),ta.adate,120)+'00'  AS DATETIME)adate
	INTO #tea_at
		from tea_at_day ta 
			inner join BasicData..[user] u 
				on ta.teaid = u.userid
	GROUP BY u.kid, CAST(CONVERT(VARCHAR(17),ta.adate,120)+'00'  AS DATETIME)

	select	COALESCE(sm.kid,sa.kid,ta.kid,1)kid,
					COALESCE(sm.adate,sa.adate,ta.adate,1)adate,
					ISNULL(sm.smcnt,0)smcnt,
					ISNULL(sa.sacnt,0)sacnt,
					ISNULL(ta.tacnt,0)tacnt
		INTO #RESULT
		from #stu_mc sm 
			full outer join #stu_at sa 
				on sm.kid = sa.kid 
				and sm.adate = sa.adate
			full outer join #tea_at ta 
				on ISNULL(sm.kid,sa.kid) = ta.kid		
				and ISNULL(sm.adate,sa.adate) = ta.adate	
					
	SELECT * FROM #RESULT ORDER BY adate
				
	DROP TABLE 	#stu_mc, #stu_at, #tea_at, #RESULT			
			
			
END

GO
