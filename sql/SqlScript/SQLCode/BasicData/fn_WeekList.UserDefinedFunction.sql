USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_WeekList]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_WeekList](@bgntime as int) returns table
as
return
  WITH
  L0   AS(SELECT 1 AS c UNION ALL SELECT 1),
  L1   AS(SELECT 1 AS c FROM L0 , L0 AS B),
  L2   AS(SELECT 1 AS c FROM L1 , L1 AS B),
  L3   AS(SELECT 1 AS c FROM L2 , L2 AS B),
  L4   AS(SELECT 1 AS c FROM L3 AS A, L3 AS B),
  Nums AS(SELECT ROW_NUMBER() OVER(ORDER BY c) AS n FROM L4),
  CET1 AS
(				SELECT left(dbo.ISOweek(dateadd(wk, n - 1,'19900101')),4) AS [year],right(dbo.ISOweek(dateadd(wk, n - 1,'19900101')),2) AS [week], 
				dateadd(hh,@bgntime,dateadd(d,datediff(d,0,dateadd(wk, n - 1,'19900101')),0) - DATEPART(dw, dateadd(wk, n - 1,'19900101'))+1 ) as StartT,
				dateadd(hh,@bgntime,dateadd(d,datediff(d,0,dateadd(wk, n - 1,'19900101')),0) - DATEPART(dw, dateadd(wk, n - 1,'19900101'))+8 ) as EndT
		FROM Nums
		WHERE n <=   3000
)SELECT * FROM CET1
GO
