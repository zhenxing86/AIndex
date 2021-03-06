USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[乐奇家园领域分类统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 乐奇家园领域分类统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[乐奇家园领域分类统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON					
	SELECT    培养能力, 阶段, 难度, 
						SUM([首次答对题数≤3])[首次答对题数≤3], SUM(首次答对题数4)首次答对题数4, SUM(首次答对题数5)首次答对题数5, 
						SUM(首次答对题数6)首次答对题数6, SUM(首次答对题数7)首次答对题数7, SUM(首次答对题数8)首次答对题数8						
	FROM         乐奇家园领域分类统计报表		
	WHERE 日期 between @bgndate And @enddate
	GROUP BY 培养能力, 阶段, 难度
END
GO
