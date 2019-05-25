USE CommonFun
GO
if OBJECT_ID('fn_MonthList') is not null drop function fn_MonthList
GO
create function dbo.fn_MonthList(@bgnday as int,@bgntime as int) returns table
as
return
  WITH CET1 AS
(		SELECT  datepart(yy,dateadd(mm, n - 1,'19900101')) as [year],
						datepart(mm,dateadd(mm, n - 1,'19900101')) as [month],
			dateadd(hh,@bgntime,dateadd(dd,@bgnday-1,              dateadd(d,datediff(d,0,dateadd(mm, n - 1,'19900101')),0) 
				- DATEPART(dd, dateadd(mm, n - 1,'19900101'))+1)) as StartT, 
			dateadd(hh,@bgntime,dateadd(dd,@bgnday-1,dateadd(mm,1,dateadd(d,datediff(d,0,dateadd(mm, n - 1,'19900101')),0) 
				- DATEPART(dd, dateadd(mm, n - 1,'19900101'))+1))) as EndT
		FROM Nums1Q
		WHERE n <= 500
)SELECT * FROM CET1		
GO


/*
SELECT * FROM dbo.fn_MonthList(4,0) where StartT 
*/