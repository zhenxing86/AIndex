USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书销售排名统计查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书销售排名统计查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书销售排名统计查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	图书名称, 所属馆藏, 内容商, 总购买次数, 总阅读次数, 
					本月购买次数, 本月阅读次数
		FROM 数字图书销售排名统计_V		
		WHERE 日期 = @bgndate and 总购买次数>0
		order by 总购买次数 desc
END
GO
