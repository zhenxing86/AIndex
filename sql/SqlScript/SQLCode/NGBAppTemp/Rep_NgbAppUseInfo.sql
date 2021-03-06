USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Rep_NgbAppUseInfo]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[Rep_NgbAppUseInfo]
AS
BEGIN
SET NOCOUNT ON
--成长日志
;with cet as
(
SELECT gb.kid,COUNT(1)CNT,'成长日志' Title 
	FROM  growthbook gb 
		INNER join diary d
		on d.gbid = gb.gbid 
		AND d.pagetplid not IN(SELECT pagetplid FROM DiaryExcetpPagetplid)
	group by gb.kid
--幼儿表现
UNION ALL
SELECT gb.kid,COUNT(1)CNT,'幼儿表现' Title 
	FROM  growthbook gb 
		INNER join diary_page_cell dp
		on dp.gbid = gb.gbid 
		AND (DP.TeaPoint <> '0,0,0,0,0,0,0,0,0,0')
	group by gb.kid
--每月进步
UNION ALL
SELECT gb.kid,COUNT(1)CNT,'每月进步' Title  
	FROM  growthbook gb 
		INNER join diary_page_month_sec dp
		on dp.gbid = gb.gbid 
		AND ISNULL(dp.TeaWord ,'')<> ''
	group by gb.kid
--月观察与评价
UNION ALL
SELECT gb.kid,COUNT(1)CNT,'月观察与评价' Title   
	FROM  growthbook gb 
		INNER join Diary_page_month_evl dp
		on dp.gbid = gb.gbid 
		AND (DP.TeaPoint <> '0,0,0,0,0,0,0,0,0')
	group by gb.kid

UNION ALL
--手工作品
select gb.kid,COUNT(1)CNT,'手工作品' Title    
	from tea_UpPhoto tu 
		inner join growthbook gb 
		on tu.gbid = gb.gbid
	group by gb.kid
),CET1 AS
(
select kid,ISNULL([成长日志],0)+ISNULL([幼儿表现],0)+ISNULL([每月进步],0)+ISNULL([月观察与评价],0)+ISNULL([手工作品],0) CNT,
		ISNULL([成长日志],0)[成长日志],ISNULL([幼儿表现],0)[幼儿表现],ISNULL([每月进步],0)[每月进步],
		ISNULL([月观察与评价],0)[月观察与评价],ISNULL([手工作品],0)[手工作品]
	from cet pivot(SUM(CNT) for Title in([成长日志],[幼儿表现],[每月进步],[月观察与评价],[手工作品])) as p
)select TOP(100) k.kid,k.kname,c.CNT,c.[成长日志],c.[幼儿表现],c.[每月进步],c.[月观察与评价],c.[手工作品] 
	from BasicData..kindergarten k 
	inner join CET1 c on k.kid = c.kid
	order by c.CNT desc
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案使用情况报表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Rep_NgbAppUseInfo'
GO
