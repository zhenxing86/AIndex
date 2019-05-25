USE HealthApp
GO
/*
-- Author:      Master̷
-- Create date: 2013-05-21
-- Description:
-- Paradef: 
-- Memo:
*/  
ALTER FUNCTION getTerm  
(   
   @time datetime  
)  
RETURNS int  
AS  
BEGIN  
	DECLARE @result int  
	set @result = 1  
	IF EXISTS(
		SELECT 1	
		from BasicData.dbo.Springday 
		where sdate >= @time
		and Month(@time) < 9
						) 
	set @result =0  
	RETURN @result  
END  