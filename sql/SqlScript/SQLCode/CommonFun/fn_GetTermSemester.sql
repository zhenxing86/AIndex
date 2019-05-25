USE CommonFun
GO
/*  
-- Author:      Master谭  
-- Create date: 2014-02-13  
-- Description: 返回时间所属的上下学期信息 
-- Paradef:   
-- Memo:  
 USE healthApp  
 GO  
 select dbo.fn_GetTermSemester(17709,'2013-08-01')  
*/    
CREATE FUNCTION fn_GetTermSemester   
(     
   @kid int, @time datetime    
)    
RETURNS int    
AS    
BEGIN    
 DECLARE @result int      
 select @result = CAST(RIGHT(term,1) AS int)   
  from BasicData.dbo.kid_term   
  where bgndate <= @time   
   and enddate >= @time  
   and kid = @kid     
 IF @@ROWCOUNT = 0     
 SELECT top(1) @result = CASE WHEN Month(@time) < 9   
   and CONVERT(varchar(4),sdate,120) = CONVERT(varchar(4),@time,120) THEN 0 ELSE 1 end   
  from BasicData.dbo.Springday   
  where sdate <= @time  
  order by sdate desc  
   
 RETURN @result    
   
END 