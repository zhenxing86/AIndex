USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书馆新用户分析报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书馆新用户分析报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书馆新用户分析报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	地域, 本月新用户数*25, 购买图书新用户数*30, 无购买行为用户数, 沉默用户数, 
					新用户充值次数*50, 新用户充值金额*60, 新用户购买图书总数*150, 
					总阅读次数*309, 购买图书册数*189, 平均每天阅读时间*1.3, 平均每天阅读册数*302
		FROM 数字图书馆新用户分析报表		
		WHERE 日期 = @bgndate 
END

GO
