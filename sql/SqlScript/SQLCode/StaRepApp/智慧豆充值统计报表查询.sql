USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[智慧豆充值统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 智慧豆充值统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[智慧豆充值统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	DATENAME(Year,日期)+N'年'+CAST(DATEPART(Month,日期) AS varchar)+N'月'--+DATENAME(Day,日期)+N'日'
	 日期, 
					sum([30元])/4 [30元], sum([50元])/4 [50元], sum([100元])/4 [100元], sum(总金额)/4 总金额--, sum(套餐充值)套餐充值, sum([合计(元)])[合计(元)]
		FROM 智慧豆充值地域统计报表
		WHERE 日期 between @bgndate And @enddate
		GROUP BY 日期
END
GO
