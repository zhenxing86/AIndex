USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[智慧豆充值地域统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 智慧豆充值地域统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[智慧豆充值地域统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	地域, sum([30元])[30元], sum([50元])[50元], sum([100元])[100元], sum(总金额)总金额, 
					sum(套餐充值)套餐充值,sum(消费金额)消费金额, sum([合计(元)])[合计(元)]
		FROM 智慧豆充值地域统计报表
		WHERE 日期 between @bgndate And @enddate
		GROUP BY 地域
END
GO
