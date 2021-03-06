USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[用户与交易统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	自动生成示例报表
-- Memo:		
exec 用户与交易统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[用户与交易统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	CAST(YEAR(日期) AS VARCHAR(10))+'年'+CAST(MONTH(日期) AS VARCHAR(10))+'月' 日期, 
					新用户数, 充值用户数, 按本购买用户数, 套餐购买用户数, 总销售额 as 总交易额
		FROM 用户与交易统计报表
		WHERE 日期 between @bgndate And @enddate
END

GO
