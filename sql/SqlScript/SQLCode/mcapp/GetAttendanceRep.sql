USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[GetAttendanceRep]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		GetAttendanceRep '2013-12-18',20882
*/
CREATE PROC [dbo].[GetAttendanceRep]
	@date datetime,
	@kid int 
AS
BEGIN
	SET NOCOUNT ON
	
	;WITH CET0 AS
	(
		SELECT stuid 
			FROM dbo.stu_at_day 
			where cdate >= CONVERT(varchar(10),@date,120)
				AND cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
		union 
		select stuid 
			FROM dbo.stu_at_month
			where cdate >= CONVERT(varchar(10),@date,120)
				AND cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
	),
	CET1 AS
	(
		select uc.cid,count(distinct sa.stuid) arrivecnt
			from CET0 sa 
				inner join BasicData.DBO.User_Child uc
					on sa.stuid = uc.userid	
				where grade <> 38
			GROUP BY uc.cid
	)
		SELECT c.cid,isnull(c.Totalcnt,0) Totalcnt,isnull(c1.arrivecnt ,0) arrivecnt
		INTO #TA
			FROM BasicData.dbo.ChildCnt_ForCid c
				LEFT join CET1 c1
					on c1.cid = c.cid
				LEFT join BasicData.dbo.class c2 
					on c.cid = c2.cid
					and c2.grade <> 38
		where c.kid = @kid
	;WITH CET0 AS
	(
		SELECT c.userid teaid 
			FROM dbo.tea_at_day ta			 
				inner join mcapp..cardinfo c
					on ta.card = c.cardno
				inner join BasicData.dbo.teacher t  
					on c.userid = t.userid  
			where ta.cdate >= CONVERT(varchar(10),@date,120)
				AND ta.cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
				and ta.kid = @kid 
		union 
		SELECT c.userid teaid  
			FROM dbo.tea_at_month	ta	 
				inner join mcapp..cardinfo c
					on ta.card = c.cardno
				inner join BasicData.dbo.teacher t  
					on c.userid = t.userid  
			where ta.cdate >= CONVERT(varchar(10),@date,120)
				AND ta.cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
				and ta.kid = @kid 
	),
	CET1 AS
	(
		select count(distinct sa.teaid) arrivecnt
			from CET0 sa 
				inner join BasicData..User_Teacher ut
					on sa.teaid = ut.userid
						and ut.kid = @kid
	)
	select COUNT(1)Totalcnt, c.arrivecnt 
		into #TB
		from BasicData..User_Teacher ut 
				cross join CET1 c
			where ut.kid = @kid	
			group by c.arrivecnt 
		
		SELECT '老师' usertype, Totalcnt, arrivecnt,Totalcnt- arrivecnt absentcnt
		FROM #TB		
		union
		SELECT '学生' usertype, SUM(Totalcnt)Totalcnt, SUM(arrivecnt)arrivecnt, SUM(Totalcnt)- SUM(arrivecnt)absentcnt
		FROM #TA
		
select c.cname,t.Totalcnt,t.arrivecnt,t.Totalcnt - t.arrivecnt absentcnt 
	from #TA t 
	inner join BasicData..class c 
	on t.cid = c.cid
	
END

GO
