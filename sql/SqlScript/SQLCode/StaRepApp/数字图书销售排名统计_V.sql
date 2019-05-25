USE StaRepApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
*/
ALTER VIEW 数字图书销售排名统计_V
AS
SELECT	a.日期,a.图书名称,a.所属馆藏,a.内容商,a.上线时间,oa1.总购买次数,oa1.总阅读次数,
				a.本月购买次数,a.本月阅读次数,
				ISNULL(oa.上月购买次数,0)上月购买次数,ISNULL(oa.上月阅读次数,0)上月阅读次数 
	FROM 数字图书销售排名统计 a 
		OUTER apply
		(
			select top(1)本月购买次数 上月购买次数,本月阅读次数 上月阅读次数 
			FROM 数字图书销售排名统计 b 
			where a.日期 > b.日期 
			AND a.图书名称 = b.图书名称 
			ORDER BY b.日期 DESC
		)oa
		OUTER apply
		(
			select sum(本月购买次数) 总购买次数,sum(本月阅读次数) 总阅读次数 
			FROM 数字图书销售排名统计 b 
			where a.图书名称 = b.图书名称 
		)oa1