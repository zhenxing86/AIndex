/*  
-- Author:      Master谭  
-- Create date: 2013-05-13  
-- Description: 函数用于获取年龄类型gtype 

 declare
 @gtype int =null,@t datetime='2010-1-1 10:00'
 select dbo.fn_gtype(@gtype,@t)
*/  
create function fn_gtype(@gtype int,@t datetime)  
returns int  
as  
begin  

if(@gtype is null or @gtype=0)
	return datediff(yy,nullif(@t,'1900-01-01'),getdate()) +  
	CASE WHEN DATEADD(year, datediff(yy,nullif(@t,'1900-01-01'),getdate()), @t) > GETDATE() THEN -1 ELSE 0 END   

return @gtype  
end   