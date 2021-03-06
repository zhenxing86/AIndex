USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_homeschool_Contact]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz	
-- Create date: 2014-8-20
-- Description:	家园互动家园联系册
/*
EXEC [reportapp].[dbo].[MasterReport_homeschool_Contact]
	@title = '2013年9月',
	@kid = 12511,
	@term = '2013-1',
	@mtype = 1
	*/
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_homeschool_Contact]
	@title varchar(50),
	@kid int,
	@term varchar(6),
  @mtype int
AS
BEGIN
	SET NOCOUNT ON
	
	select '掌握本园家园联系册的填写数量<br />可以看出各班级对家园联系册的使用积极性'string
	
	if @kid = 12511
	set @term = '2013-1'
	set @title = '2013年9月'
	
	declare @homebookType int,@viewName VARCHAR(50)

	select @homebookType = case when fm.hbModList like '%AdvSummary%' then 4 else 3 end  
		from [ngbapp].dbo.fn_ModuleSet(@kid,@term)fm
	--1：幼儿表现
	IF @mtype = 1
	BEGIN
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T1
			from [ngbapp]..homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN [ngbapp]..fn_GetCellsetList(@term,@kid) fg 				
				left join [ngbapp]..growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join [ngbapp]..diary_page_cell dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.title
					AND (DP.TeaPoint <> '0,0,0,0,0,0,0,0,0,0')
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title
	
	  select	t.cname as 班级, t.title as 标题, (t.on_count +t.off_count) 班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T1 t 
	order by t.pos
	END
		-------------------------------------------------------------

	--2：每月进步
	IF @mtype =2
	
	BEGIN
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T2
			from [ngbapp]..homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN [ngbapp]..fn_GetMonAdvList(@term,@kid) fg 				
				left join [ngbapp]..growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join [ngbapp]..diary_page_month_sec dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.title
					and ISNULL(dp.TeaWord ,'')<> ''
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title	
							

select	t.cname as 班级, t.title as 标题,(t.on_count +t.off_count)  班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T2 t 
		
	order by t.pos
	END
	-------------------------------------------------------------
--3：老师上传
	IF @mtype =3
	BEGIN
	select	uc.cid, uc.cname, fg.title,
					COUNT(case when dp.pictype = 1 then 1 else null end)on_count,
					COUNT(case when dp.pictype = 2 then 1 else null end)off_count, 		
					hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
					@homebookType homebookType
			INTO #T3
			from [ngbapp]..homebook hb				
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN [ngbapp]..fn_GetMonAdvList(@term,@kid) fg 				
				left join [ngbapp]..growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join [ngbapp]..tea_UpPhoto dp
					on dp.gbid = gb.gbid 
					and fg.title = DATENAME(Year,dp.updatetime)+N'年'+CAST(DATEPART(Month,dp.updatetime) AS varchar)+N'月'
					and dp.deletetag = 1
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title
							
	select	t.cname as 班级, t.title as 标题,(t.on_count +t.off_count)  班级总人数, 
				t.on_count as 生活剪影, t.off_count as 手工作品 
	from #T3 t 
	
	order by t.pos
END					
-------------------------------------------------------------
--4：观察记录
	IF @mtype =4
	BEGIN
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T4
			from [ngbapp]..homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN [ngbapp]..fn_GetMonAdvList(@term,@kid) fg 				
				left join [ngbapp]..growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join [ngbapp]..Diary_page_month_evl dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.months
					and ISNULL(dp.TeaPoint ,'')<> '0,0,0,0,0,0,0,0,0'
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title	
							
select	t.cname as 班级, t.title as 标题, (t.on_count +t.off_count) 班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T4 t 
	order by t.pos	
	END		


END

GO
