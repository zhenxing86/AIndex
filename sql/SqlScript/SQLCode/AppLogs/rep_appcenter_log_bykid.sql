USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_appcenter_log_bykid]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author: YZ  
-- Create date: 2014-04-26  
-- Description: 用户行为查询  
-- [rep_appcenter_log_bykid] '2014-1-1','2014-4-1',12511  
-- =============================================  
CREATE PROCEDURE [dbo].[rep_appcenter_log_bykid]  
  
@bgndate date,  
@enddate date,  
@kid int = null
  
AS  
BEGIN  
 SET NOCOUNT ON;  
 if @kid is Null
 begin
   select al.userid,  
       u.name,  
       k.kname,  
       al.actiondatetime,  
       lat.actionname  
   into #temp
   from applogs..appcenter_log al  
    inner join BasicData..[user] u  
      on al.userid = u.userid  
    inner join applogs..log_action_type lat  
      on al.appid = lat.appidid  
    inner join BasicData..kindergarten k  
      on u.kid = k.kid  
   where al.usertype = 98  
     and al.actiondatetime >= CONVERT(VARCHAR(10),@bgndate,120)  
     and al.actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)  
   
   SELECT userid, name 姓名, kname 所属幼儿园,
          STUFF((SELECT '→' + actionname+'(' + Convert(Varchar(20), actiondatetime, 120) + ')' AS [text()]
                   FROM #temp AS b
                   WHERE b.userid = a.userid and a.name = b.name and a.kname = b.kname
                   Order By b.actiondatetime
                   FOR XML PATH('')), 1, 1, '') AS 操作
     FROM #temp AS a
     Group By userid, name, kname
     Order by kname;
   drop table #temp
 end
 else begin
   select al.userid,  
         u.name 姓名,  
         k.kname 所属幼儿园,  
         al.actiondatetime 操作时间,  
         lat.actionname 操作  
    from applogs..appcenter_log al  
      inner join BasicData..[user] u  
        on al.userid = u.userid  
      inner join applogs..log_action_type lat  
        on al.appid = lat.appidid  
      inner join BasicData..kindergarten k  
        on u.kid = k.kid  
    where u.kid = @kid  
      --and u.usertype = 98  
      and al.usertype = 98  
      and al.actiondatetime >= CONVERT(VARCHAR(10),@bgndate,120)  
      and al.actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)  
    order by al.actiondatetime  
  end
 
END  

GO
