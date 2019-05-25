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
ALTER function dbo.fn_randzz(@zz2 int,@zz3 int,@zz4 int,@zz5 int,@zz6 int,@zz7 int,@zz8 int,@zz9 int,@zz10 int,@zz11 int)
returns varchar(100)
begin
	declare @return varchar(100)
	select @return = 
CASE WHEN @zz2  between 1 and 8 then ',2'  else '' end 
+ CASE WHEN @zz3  between 1 and 8 then ',3'  else '' end 
+ CASE WHEN @zz4  between 1 and 8 then ',4'  else '' end 
+ CASE WHEN @zz5  between 1 and 3  then ',5'  else '' end 
+ CASE WHEN @zz6  between 1 and 3  then ',6'  else '' end 
+ CASE WHEN @zz7  between 1 and 1  then ',7'  else '' end 
+ CASE WHEN @zz8  between 1 and 2  then ',8'  else '' end 
+ CASE WHEN @zz9  between 1 and 8 then ',9'  else '' end 
+ CASE WHEN @zz10 between 1 and 3  then ',10' else '' end 
+ CASE WHEN @zz11 between 1 and 2  then ',11' else '' end 
	IF CHARINDEX(',',@return) = 1
	select @return = stuff(@return,1,1,'')

return @return
end

