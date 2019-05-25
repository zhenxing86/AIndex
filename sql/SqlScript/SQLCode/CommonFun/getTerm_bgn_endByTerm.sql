USE CommonFun
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-03  
-- Description: 函数用于返回某时间所属学期的起止时间  
-- Paradef:   
-- Memo: 
SELECT * FROM CommonFun.[dbo].getTerm_bgn_endByTerm('2013-1',12511)  
*/   
CREATE function [dbo].getTerm_bgn_endByTerm(@term as varchar(6),@kid int)   
returns   @t   table(bgndate datetime, enddate datetime)     
as  
BEGIN  
insert into @t  
 select bgndate,enddate    
  from BasicData.dbo.kid_term     
  where term = @term
   and kid = @kid       
 IF @@ROWCOUNT = 0
 insert into @t     
 SELECT top(1) case when RIGHT(@term,1) = '1' then CONVERT(VARCHAR(4),DATEADD(YY,-1,s.sdate),120) + '-09-01' else s.sdate END,  
 case when RIGHT(@term,1) = '1' then s.sdate else CONVERT(VARCHAR(4),s.sdate,120) + '-09-01' END  
  from BasicData.dbo.Springday s   
  where s.term >= @term  
  order by s.sdate   
 return  
END
GO

SELECT * FROM CommonFun.[dbo].getTerm_bgn_endByTerm('2014-0',12511)  