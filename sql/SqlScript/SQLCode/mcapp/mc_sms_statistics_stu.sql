USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_statistics_stu]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE TABLE #kid(kid int)              
  DECLARE @flag int        
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',134,'0'   

;with cet as(
 SELECT smstype, sm.kid    
    from sms_mc sm    
     inner join #kid k on k.kid = sm.kid    
    where sendtime >= '2014-01-01'    
     and sendtime < '2014-06-01'    
     AND smstype IN(8,9,10,11)  ) 

 select t.kid,bk.kname,     
         COUNT(CASE WHEN t.smstype = 8 then 1 else null end) dayyccnt,    
         COUNT(CASE WHEN t.smstype = 9 then 1 else null end) carecnt,    
         COUNT(CASE WHEN t.smstype = 10 then 1 else null end) monthcnt,    
         COUNT(CASE WHEN t.smstype = 11 then 1 else null end) seasoncnt    
    from cet t    
      inner join BasicData..kindergarten bk on bk.kid = t.kid    
    GROUP BY t.kid,bk.kname    
    
--select @flag,* from #kid
  drop table #kid
   
mc_sms_statistics_stu '','','','',-1,'2014-01-01','2014-06-01',134,''
*/
CREATE PROCEDURE [dbo].[mc_sms_statistics_stu]    
  @provinceid nvarchar(10),     
 @cityid nvarchar(10),     
 @areaid nvarchar(10),     
 @kname varchar(50),     
 @kid int,    
 @bgndate datetime,    
 @enddate datetime,  
 @cuid int=0,         
 @developer varchar(100)=''    
     
AS    
BEGIN    
  SET NOCOUNT ON    
  CREATE TABLE #T(smstype int, kid int)     
 CREATE TABLE #kid(kid int)    
  DECLARE @flag int    
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer       
  IF @flag = -1     
  BEGIN      
    INSERT INTO #T     
    SELECT smstype, kid    
      from sms_mc    
      where sendtime >= CONVERT(VARCHAR(10),@bgndate,120)    
        and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)    
        AND smstype IN(8,9,10,11)    
  END    
  ELSE     
  BEGIN    
   INSERT INTO #T     
   SELECT smstype, sm.kid    
    from sms_mc sm    
     inner join #kid k on k.kid = sm.kid    
    where sendtime >= CONVERT(VARCHAR(10),@bgndate,120)    
     and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)    
     AND smstype IN(8,9,10,11)    
  END     
      
  select t.kid,bk.kname,     
         COUNT(CASE WHEN t.smstype = 8 then 1 else null end) dayyccnt,    
         COUNT(CASE WHEN t.smstype = 9 then 1 else null end) carecnt,    
         COUNT(CASE WHEN t.smstype = 10 then 1 else null end) monthcnt,    
         COUNT(CASE WHEN t.smstype = 11 then 1 else null end) seasoncnt    
    from #T t    
      inner join BasicData..kindergarten bk on bk.kid = t.kid    
    GROUP BY t.kid,bk.kname    
    
END 
GO
