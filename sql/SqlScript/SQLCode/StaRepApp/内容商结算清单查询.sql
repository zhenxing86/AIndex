USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[内容商结算清单查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 内容商结算清单查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[内容商结算清单查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	
	 图书名称, 馆别, 内容商, 单价, sum(购买次数)购买次数, sum(购买金额)购买金额, 结算比例, sum(结算金额)结算金额
FROM         内容商结算清单
		WHERE 日期 between @bgndate And @enddate
		GROUP BY 图书名称, 馆别, 内容商, 单价, 结算比例
END
GO
