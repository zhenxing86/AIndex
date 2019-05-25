USE CommonFun
GO
/*函数用于返回时间序列
		参数：@s 开始时间
					@e 结束时间
注意：
Author:磊仔
Date：2012-05-01
IN：SQL SERVER 2005                                   
 */   
ALTER function dbo.fn_DayList(@s as datetime,@e as datetime) returns table
as
return
with CET1 AS
(SELECT @s + n - 1 AS StartT,@s + n   AS EndT
		FROM dbo.Nums1W
		WHERE n <= DATEDIFF(day, @s, @e) + 1	
)SELECT * FROM CET1		
GO

select * from dbo.fn_DayList('2013-01-01','2013-01-29') --where EndT >='20120110' and EndT <='20120115'
