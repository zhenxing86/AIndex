USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[乐奇家园答题统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 乐奇家园答题统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[乐奇家园答题统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON					
				
	SELECT	题目名称, 培养能力, 阶段, 难度, SUM(答对次数)答对次数, SUM(首次答对次数)首次答对次数, 
					SUM(答错次数)答错次数, SUM(放弃次数)放弃次数
		FROM 乐奇家园答题统计报表	
		WHERE 日期 between @bgndate And @enddate
		GROUP BY 题目名称, 培养能力, 阶段, 难度
END
GO
