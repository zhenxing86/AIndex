USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-03
-- Description:	函数用于返回某时间所属学期的起止时间
-- Paradef: 
-- Memo:	SELECT * FROM CommonFun.[dbo].getTerm_bgn_end(GETDATE(),12511)
*/ 
ALTER function [dbo].getTerm_bgn_end(@time as datetime,@kid int) 
returns   @t   table(bgndate datetime, enddate datetime)   
as
BEGIN
insert into @t
 select bgndate,enddate  
  from BasicData.dbo.kid_term   
  where bgndate <= @time   
   and enddate >= @time 
   and kid = @kid     
 IF @@ROWCOUNT = 0  
 insert into @t   
 SELECT top(1) case when @time >= CONVERT(VARCHAR(4),s.sdate,120) + '-09-01' then CONVERT(VARCHAR(4),s.sdate,120) + '-09-01' else s.sdate END,
 case when @time >= CONVERT(VARCHAR(4),s.sdate,120) + '-09-01' then ca.sdate else CONVERT(VARCHAR(4),s.sdate,120) + '-09-01' END
  from BasicData.dbo.Springday s 
		cross apply(select top(1)sdate from BasicData.dbo.Springday where sdate > s.sdate order by sdate) ca  
  where s.sdate <= @time
  order by s.sdate desc  
	return
END