USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:	select commonfun.dbo.fn_libtermrule('2013-06-01','2013-11-01')	
*/
CREATE FUNCTION fn_libtermrule(@s datetime, @e datetime)
	RETURNS INT
AS
BEGIN
	declare @result int
	;with cet as
	(
		select '20100501' node, 0 flag
		union
		select '20101001',1 flag 
	)
	 SELECT @result = 
	 case when  COUNT(1) > 1 then 2 ELSE MAX(flag)  end
			FROM Nums100 n cross join cet c
		WHERE n <= 500  
	and DATEADD(YY,n,c.node) >= @s
	and DATEADD(YY,n,c.node) <= @e
	RETURN @result
END