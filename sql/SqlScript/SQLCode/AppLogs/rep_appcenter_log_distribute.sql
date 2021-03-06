USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_appcenter_log_distribute]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author: YZ  
-- Create date: 2014-04-26  
-- Description: 用户操作分布情况  
-- [rep_appcenter_log_distribute_bykid] '2014-1-1','2014-4-1'
-- =============================================  
CREATE PROCEDURE [dbo].[rep_appcenter_log_distribute]  
  
@bgndate date,  
@enddate date,  
@kid int  
  
AS  
BEGIN  
 SET NOCOUNT ON;  
  select al.userid,  
         u.name 姓名,  
         k.kname 所属幼儿园,  
         count(lat.actionname),  
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
    group by al.userid,u.name,k.kname,lat.actionname  
    order by userid,操作  
END  
GO
