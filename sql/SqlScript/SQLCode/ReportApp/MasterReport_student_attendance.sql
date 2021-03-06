USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_attendance]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz	
-- Create date: 2014-8-28
-- Description:	新版学生考勤报表
--[reportapp]..[MasterReport_student_attendance] '2013-8-29',12511
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_student_attendance]
  @date date,
	@kid int 
AS
BEGIN
	SET NOCOUNT ON
	
	 select '掌握本园学生考勤情况<br />'string
	
	;WITH CET0 AS
	(
		SELECT  stuid 
			FROM  [mcapp].dbo.stu_at_day 
			where cdate >= CONVERT(varchar(10),@date,120)
				AND cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
		union 
		select stuid 
			FROM [mcapp].dbo.stu_at_month
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
			FROM [mcapp].dbo.tea_at_day ta			 
				inner join mcapp..cardinfo c
					on ta.card = c.cardno
				inner join BasicData.dbo.teacher t  
					on c.userid = t.userid  
			where ta.cdate >= CONVERT(varchar(10),@date,120)
				AND ta.cdate < CONVERT(varchar(10),DATEADD(DD,1,@date),120)
				and ta.kid = @kid 
		union 
		SELECT c.userid teaid  
			FROM [mcapp].dbo.tea_at_month	ta	 
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
		

select t.cid,
       c.cname,
       t.Totalcnt,
       t.arrivecnt,
       t.Totalcnt - t.arrivecnt absentcnt,
       cast(cast((t.arrivecnt*1.0 / t.Totalcnt) as numeric(16,2))*100 as varchar(10))+'%' as per 
	from #TA t 
	inner join BasicData..class c 
	on t.cid = c.cid
	
END


GO
