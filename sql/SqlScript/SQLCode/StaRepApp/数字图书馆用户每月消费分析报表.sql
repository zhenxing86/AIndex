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
exec 数字图书馆用户每月消费分析报表查询 '2013-07-01','2013-07-01'
*/
ALTER PROC 数字图书馆用户每月消费分析报表查询
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	地域, 用户总数, 购买用户数, 无购买行为用户数, 沉默用户数, 
					用户充值次数, 用户充值金额, 购买图书总数, 阅读次数, 
					购买图书册数, 平均每天阅读时间, 平均每天阅读册数
		FROM 数字图书馆用户每月消费分析报表		
		WHERE 日期 = @bgndate 
END
GO