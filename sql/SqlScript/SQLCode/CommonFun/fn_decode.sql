USE CommonFun
GO	
/*  
-- Author:      Master谭  
-- Create date: 2013-09-07  
-- Description: 该函数用于判断非空字符串的个数  
-- Memo:    
*/  
ALTER function fn_decode(@s varchar(50))
returns varchar(50)  
as  
begin  
	DECLARE @R VARCHAR(50) = ''
	declare @x1 int,@x2 int
	while(len(@s)>0)
	BEGIN
	set @x1 = ascii(@s)
	set @x1 = case when @x1 >=48 and @x1 < 58 then @x1 - 48 else @x1-97+10 END
	set @s = stuff(@s,1,1,'')
	set @x2 = ascii(@s)
	set @x2 = case when @x2 >=48 and @x2 < 58 then @x2 - 48 else @x2-97+10 END
	set @s = stuff(@s,1,1,'')
	set @R = @R + char(  ( (@x1 * POWER(2,4)) & 0xf0) | (@x2 & 0x0f) )
	END
return isnull(@R,'')  
end