USE HealthApp
GO
/*
-- Author:      Master̷
-- Create date: 2013-05-21
-- Description:
-- Paradef: 
-- Memo:
	USE healthApp
	GO
	select dbo.getTerm_New(17709,getdate())
*/  
ALTER FUNCTION getTerm_New  
(   
   @kid int, @time datetime  
)  
RETURNS varchar(6)  
AS  
BEGIN  
	DECLARE @result varchar(6)   	
	select	@result = term 
		from BasicData.dbo.kid_term 
		where bgndate <= @time 
			and enddate >= @time
			and kid = @kid			
	IF @@ROWCOUNT = 0 		
	SELECT top(1) @result = 
					CONVERT(varchar(4),sdate,120) +'-'+ CASE WHEN Month(@time) < 9 
			and CONVERT(varchar(4),sdate,120) = CONVERT(varchar(4),@time,120) then '0' ELSE '1' end 
		from BasicData.dbo.Springday 
		where sdate <= @time
		order by sdate desc
	
	RETURN @result  
	
END  