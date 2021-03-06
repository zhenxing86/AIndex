USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书馆地域访问量统计查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书馆地域访问量统计查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书馆地域访问量统计查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON										
	SELECT	地域, SUM([总阅读图书(本)])[总阅读图书(本)], SUM(总阅读次数)总阅读次数, 
					AVG([人均每次登录阅读图书(本)])[人均每次登录阅读图书(本)], 
					AVG(人均每次登录阅读次数)人均每次登录阅读次数, 
					AVG([人均购买图书(本)])[人均购买图书(本)], 
					AVG(人均充值金额)人均充值金额, 
					AVG(平均加载时间)平均加载时间
		FROM 数字图书馆地域访问量统计		
		WHERE 日期 between @bgndate And @enddate
		GROUP BY 地域
END

GO
