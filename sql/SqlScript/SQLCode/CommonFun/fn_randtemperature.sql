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
-- Memo:		
*/
alter function dbo.fn_randtemperature(@x bigint)
returns numeric(9,1)
begin
IF @x <=5
RETURN 0
	return 
	35.93809
	+0.05308*power(@x,1)
	-0.00442*power(@x,2)
	+3.75352E-4*power(@x,3)
	-1.89412E-5*power(@x,4)
	+5.41139E-7*power(@x,5)
	-8.87017E-9*power(@x,6)
	+8.21088E-11*power(@x,7)
	-3.95168E-13*power(@x,8)
	+7.60173E-16*power(@x,9)
end

