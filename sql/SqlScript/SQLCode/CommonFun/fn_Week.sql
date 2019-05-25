USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-14
-- Description:	函数用返回某天所属星期的数字格式，消除@@DATEFIRST 的影响，固定1为星期一，7为星期天
-- Memo:		
*/
ALTER FUNCTION fn_Week(@t datetime)
returns int
as
begin
	return DATEPART(weekday, getdate() + @@DATEFIRST - 1)
end