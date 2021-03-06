USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-08
-- Description:	过程用于返回幼儿表现的老师填写情况
-- Memo:

EXEC rep_homebook_week_Report
	@kid = 12511,
	@cid = 46144,
	@term = '2013-1',
	@order = 'title',	--(title,on_count,off_count)
	@page = 1,
	@size = 100		
*/
CREATE PROCEDURE [dbo].[rep_homebook_week_Report]
	@kid int,
	@cid int,
	@term varchar(6),
	@order varchar(50),	--(title,on_count,off_count)
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	select	@cid cid, uc.cname, fg.title,	count(dp.diaryid)on_count,
					COUNT(case when dp.diaryid is null then 1 else null end)off_count, hb.hbid, fg.pos, 
					case when fm.hbModList like '%AdvSummary%' then 4 else 3 end homebookType
		INTO #T
		from homebook hb
			CROSS apply(select * from dbo.fn_ModuleSet(@kid,@term))fm
			inner join BasicData..User_Child uc 
				on hb.cid = @cid
				and hb.term = @term
				and hb.cid = uc.cid
			cross JOIN dbo.fn_GetCellsetList(@term,@kid) fg 
			left join growthbook gb 
				on hb.term = gb.term
				and uc.userid = gb.userid
			left join diary_page_cell dp
				on dp.gbid = gb.gbid 
				and fg.pos = dp.title
				AND (DP.TeaPoint <> '0,0,0,0,0,0,0,0,0,0')
		group by hb.hbid, uc.cname, fg.pos, fg.title,fm.hbModList 



   exec sp_GridViewByPager  
    @viewName = '#T',             --表名  
    @fieldName = ' cid,cname, title, on_count, off_count, hbid, pos, homebookType',      --查询字段  
    @keyName = 'pos',       --索引字段  
    @pageSize = @size,                 --每页记录数  
    @pageNo = @page,                     --当前页  
    @orderString = @order,          --排序条件  
    @whereString = ' 1 = 1 ' ,  --WHERE条件  
    @IsRecordTotal = 1,             --是否输出总记录条数  
    @IsRowNo = 0

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过程用于返回幼儿表现的老师填写情况' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@cid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@order'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report', @level2type=N'PARAMETER',@level2name=N'@size'
GO
