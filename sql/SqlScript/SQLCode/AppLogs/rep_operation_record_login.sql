USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_operation_record_login]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author: YZ  
-- Create date: 2014-5-20  
-- Description: 手机端登陆人数变化  
-- [dbo].[rep_operation_record_login]'2014-5-1','2014-5-21'  
-- =============================================  
CREATE PROCEDURE [dbo].[rep_operation_record_login]  
   @bgndate date,  
   @enddate date  
AS  
BEGIN  
  SET NOCOUNT ON;  
  select CONVERT(varchar(10), r.operdate, 120) as 日期,  
         COUNT(distinct r.userid) as 登陆总数,  
         COUNT(distinct(case when r.appname = 1 then r.userid else 0 end)) as 老师端登陆人数,  
         COUNT(distinct(case when r.appname in(97,98) then r.userid else 0 end)) as 园长端登陆人数,  
         COUNT(distinct(case when r.appname = 0 then r.userid else 0 end)) as 家长端登陆人数  
    from AppLogs..operation_record r  
    where r.operdate >= @bgndate and r.operdate < Dateadd(dd, 1, @enddate)
      and r.operation in(1,134) --老师和园长端登陆为1，家长端登陆为134  
    GROUP BY CONVERT(varchar(10), r.operdate, 120)
    order by 日期 desc  
/*
  select cast(DATEADD(DD,n-1,@bgndate)as varchar(10)) as 日期,  
         COUNT(distinct r.userid) as 登陆总数,  
         COUNT(distinct(case when r.appname = 1 then r.userid else null end)) as 老师端登陆人数,  
         COUNT(distinct(case when r.appname in(97,98) then r.userid else null end)) as 园长端登陆人数,  
         COUNT(distinct(case when r.appname = 0 then r.userid else null end)) as 家长端登陆人数  
  
  from CommonFun..Nums100 n  
  left join AppLogs..operation_record r  
    on r.operdate >= DATEADD(DD,n-1,@bgndate)   
    and r.operdate < DATEADD(DD,n,@bgndate)  
   
 where n < = DATEDIFF(DD,@bgndate,@enddate)+1  
    and r.operation in(1,134) --老师和园长端登陆为1，家长端登陆为134  
    GROUP BY n  
    order by n desc  
  */
END  
GO
