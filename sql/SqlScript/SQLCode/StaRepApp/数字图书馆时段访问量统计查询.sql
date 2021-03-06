USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书馆时段访问量统计查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书馆时段访问量统计查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书馆时段访问量统计查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON					
	SELECT	访问时段, SUM(在线用户数)在线用户数, SUM([阅读图书(本)])[阅读图书(本)], 
					SUM(国学)国学, SUM(学前)学前, SUM(绘本)绘本, SUM(成长)成长, 
					SUM(科学)科学, SUM(故事)故事, SUM(益智)益智
	FROM         数字图书馆时段访问量统计	
			WHERE 日期 between @bgndate And @enddate
			GROUP BY 访问时段
END

GO
