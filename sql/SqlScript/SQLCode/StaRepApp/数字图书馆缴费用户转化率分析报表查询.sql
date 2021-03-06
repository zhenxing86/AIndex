USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书馆缴费用户转化率分析报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书馆缴费用户转化率分析报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书馆缴费用户转化率分析报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	地域, 用户总数, 缴费用户, 上线新书, [1个月缴费用户数], [1个月转化率], 
					[2个月缴费用户数], [2个月转化率], [3个月缴费用户数], [3个月转化率], 
					半年缴费用户数, 半年转化率, [≥6个月缴费用户数], [≥6个月转化率]
	FROM         数字图书馆缴费用户转化率分析报表
		WHERE 日期 = @bgndate 
END

GO
