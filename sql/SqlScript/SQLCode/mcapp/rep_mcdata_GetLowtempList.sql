USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_GetLowtempList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
/* =============================================        
-- Author:  yz       
-- Create date: 2014-11-17        
-- Description: 低温
--[mcapp]..[rep_mcdata_GetLowtempList] '2014-11-11','2014-11-17',1,'',24072     
-- =============================================*/        
CREATE PROCEDURE [dbo].[rep_mcdata_GetLowtempList]      
@bgndate datetime, --默认当天        
@enddate datetime, --默认当天        
@cuid int=-1,                   
@developer varchar(100)='',
@kid int 
        
AS        
BEGIN        
 SET NOCOUNT ON;        
       
 CREATE TABLE #RESULT(kid int, kname nvarchar(200),tw numeric(6,3))           
 CREATE TABLE #kid(kid int)          
  DECLARE @flag int          
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',@cuid,@developer     
      
  insert into #RESULT(kid,tw)    
  select d.kid,r.tw     
  from mcapp..stu_mc_day_raw r    
   inner join mcapp..stu_mc_day d        
  on r.[card] = d.[card] and r.cdate = d.cdate     
   where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)       
    and isnumeric(r.ta)= 1 and isnumeric(r.tw)= 1  and isnumeric(r.toe)= 1      
    and CAST(r.toe as numeric(6,2))> 30     
                 
  IF @flag = -1           
  BEGIN       
   select r.kid,k.kname as 幼儿园名称,        
    cast(1.0 * COUNT(case when cast(tw as numeric(6,2))<=36.5 then tw else null end)        
    / COUNT(tw)as numeric(5,3))as 比例      
    from #RESULT r    
    inner join BasicData..kindergarten k       
   on r.kid = k.kid       
    group by r.kid,k.kname     
    having cast(1.0 * COUNT(case when cast(tw as numeric(6,2))<=36.5 then tw else null end)        
    / COUNT(tw)as numeric(5,3)) >= 0.3       
           
  END      
  ELSE      
  BEGIN      
   select r.kid,k.kname as 幼儿园名称,        
   cast(1.0 * COUNT(case when cast(tw as numeric(6,2))<=36.5 then tw else null end)        
   / COUNT(tw)as numeric(5,3))as 比例      
    from #RESULT r    
    inner join BasicData..kindergarten k       
  on r.kid = k.kid      
    inner join #kid      
  on r.kid = #kid.kid       
    group by r.kid,k.kname     
    --having cast(1.0 * COUNT(case when cast(tw as numeric(6,2))<=36.5 then tw else null end)/ COUNT(tw)as numeric(5,3)) >= 0.3
         
   END    
       
  drop table #RESULT    
END 
GO
