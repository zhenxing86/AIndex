use CommonFun
go
/*    
-- Author:      xie  
-- Create date: 2014-07-02   
-- Description: 根据时间和kid获取当前学期 
-- Paradef: @offset(0:只根据时间获取，1：根据时间或者iscurrent来获取）    
-- Memo:
    
 update  BasicData.dbo.kid_term  set term='2014-1',iscurrent=1 where kid=12511
 declare @date datetime='2014-07-02 10:00:00'  
 select dbo.fn_getCurrentTerm(23115,@date,0)    
 
 select * from  BasicData.dbo.kid_term where kid=12511  
 select* from BasicData.dbo.Springday  
 where sdate <= @date   
  order by sdate desc    
  
  declare @date datetime='2014-07-02 10:00:00'
  exec getterminfo 23115,date
  [GetTermInfo] 23115,'2014-08-22'      
*/      
alter FUNCTION [dbo].[fn_getCurrentTerm](@kid int,@date datetime,@offset int)       
returns nvarchar(10)    
AS      
BEGIN    

 declare @term nvarchar(10) ='2000-0' 
 select top 1 @term = term    
  from BasicData.dbo.kid_term     
  where ((bgndate <= @date  
   and enddate >= @date) 
    or @offset=1
  ) and kid = @kid and iscurrent =1   
 order by term desc
       
 declare @default_term nvarchar(6) ='2000-0'   
 SELECT top(1) @default_term = CASE WHEN Month(@date) < 9     
   and CONVERT(varchar(4),sdate,120) = CONVERT(varchar(4),@date,120) THEN CONVERT(varchar(4),sdate,120)+'-0' ELSE CONVERT(varchar(4),sdate,120)+'-1' end     
  from BasicData.dbo.Springday     
  where sdate <= @date   
  order by sdate desc    
 
 if @term< @default_term 
	select @term =@default_term 

 RETURN @term      
     
END   

