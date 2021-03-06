USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report_Class]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-08
-- Description:	过程用于返回幼儿表现的老师填写情况
-- Memo:

EXEC rep_homebook_week_Report_Class
	@title = '2013年9月',
	@kid = 12511,
	@term = '2013-1',
	@order = 'on_count',	--(title,on_count,off_count)
	@page = 1,
	@size = 100		
*/
CREATE PROCEDURE [dbo].[rep_homebook_week_Report_Class]
	@title varchar(50),
	@kid int,
	@term varchar(6),
	@order varchar(50),
	@page int,
	@size int,
	@mtype int = 1
AS
BEGIN
	SET NOCOUNT ON
	
	declare @homebookType int,@viewName VARCHAR(50)

	select @homebookType = case when fm.hbModList like '%AdvSummary%' then 4 else 3 end  
		from dbo.fn_ModuleSet(@kid,@term)fm
	--1：幼儿表现
	IF @mtype in(0,1) 
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T1
			from homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN dbo.fn_GetCellsetList(@term,@kid) fg 				
				left join growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join diary_page_cell dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.title
					AND (DP.TeaPoint <> '0,0,0,0,0,0,0,0,0,0')
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title


	IF @mtype in(0,2) 
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T2
			from homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN dbo.fn_GetMonAdvList(@term,@kid) fg 				
				left join growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join diary_page_month_sec dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.title
					and ISNULL(dp.TeaWord ,'')<> ''
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title	

	IF @mtype in(0,3) 
	select	uc.cid, uc.cname, fg.title,
					COUNT(case when dp.pictype = 1 then 1 else null end)on_count,
					COUNT(case when dp.pictype = 2 then 1 else null end)off_count, 		
					hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
					@homebookType homebookType
			INTO #T3
			from homebook hb				
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN dbo.fn_GetMonAdvList(@term,@kid) fg 				
				left join growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join tea_UpPhoto dp
					on dp.gbid = gb.gbid 
					and fg.title = DATENAME(Year,dp.updatetime)+N'年'+CAST(DATEPART(Month,dp.updatetime) AS varchar)+N'月'
					and dp.deletetag = 1
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title

	IF @mtype in(0,4) 
	select	uc.cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
						COUNT(case when dp.diaryid is null then 1 else null end)off_count, 
						hb.hbid, row_number()OVER(order by fg.pos, g.[order], uc.corder) - 1 pos, 
						@homebookType homebookType
			INTO #T4
			from homebook hb
				inner join BasicData..User_Child uc 
					on hb.kid = @kid
					and hb.term = @term
					and hb.cid = uc.cid
				inner join BasicData..grade g
					on uc.grade = g.gid
				CROSS JOIN dbo.fn_GetMonAdvList(@term,@kid) fg 				
				left join growthbook gb 
					on gb.term = @term
					and uc.userid = gb.userid
				left join Diary_page_month_evl dp
					on dp.gbid = gb.gbid 
					and fg.pos = dp.months
					and ISNULL(dp.TeaPoint ,'')<> '0,0,0,0,0,0,0,0,0'
			where  (fg.title = @title OR ISNULL(@title,'')='')
			group by hb.hbid, uc.cid, uc.cname, g.[order], 
							uc.corder, fg.pos, fg.title					

if @mtype <> 0
begin
		SELECT @viewName = '#T'+CAST(@mtype AS VARCHAR(10)) 
   exec sp_GridViewByPager  
    @viewName = @viewName,             --表名  
    @fieldName = ' cid, cname, title, on_count, off_count, hbid, pos, homebookType',      --查询字段  
    @keyName = 'pos',       --索引字段  
    @pageSize = @size,                 --每页记录数  
    @pageNo = @page,                     --当前页  
    @orderString = @order,          --排序条件  
    @whereString = ' 1 = 1 ' ,  --WHERE条件  
    @IsRecordTotal = 1,             --是否输出总记录条数  
    @IsRowNo = 0
end
ELSE
BEGIN
--1：幼儿表现
select	t.cname as 班级, t.title as 标题, cf.Totalcnt 班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T1 t 
		inner join BasicData..ChildCnt_ForCid cf 
			on t.cid = cf.cid
	order by t.pos
--2：每月进步
select	t.cname as 班级, t.title as 标题, cf.Totalcnt 班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T2 t 
		inner join BasicData..ChildCnt_ForCid cf 
			on t.cid = cf.cid
	order by t.pos
--3：老师上传
select	t.cname as 班级, t.title as 标题, cf.Totalcnt 班级人数, 
				t.on_count as 生活剪影, t.off_count as 手工作品 
	from #T3 t 
		inner join BasicData..ChildCnt_ForCid cf 
			on t.cid = cf.cid
	order by t.pos
--4：观察记录
select	t.cname as 班级, t.title as 标题, cf.Totalcnt 班级总人数, 
				t.on_count as 已填人数, t.off_count as 未填人数 
	from #T4 t 
		inner join BasicData..ChildCnt_ForCid cf 
			on t.cid = cf.cid
	order by t.pos

END


END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过程用于返回幼儿表现的老师填写情况' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@order'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0全部，1幼儿表现，2每月进步，3老师上传，4观察记录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_Class', @level2type=N'PARAMETER',@level2name=N'@mtype'
GO
