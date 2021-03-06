USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_appcenter_log_vitality]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author: YZ    
-- Create date: 2014-04-26    
-- Description: 全局用户活跃度分析
-- [rep_appcenter_log_vitality] '2014-5-10','2014-5-20','2014-5-10','2014-5-20' 
-- =============================================    
CREATE PROCEDURE [dbo].[rep_appcenter_log_vitality] 
   @kidbgndate date,
   @kidenddate date,   
   @bgndate date,
   @enddate date
AS    
BEGIN    
 SET NOCOUNT ON;    
 select k.kid,
        k.kname 幼儿园,
        Convert(varchar(10), k.actiondate, 120) 注册时间, 
        COUNT(id) 操作总数
   from applogs..appcenter_log al
     inner join BasicData..[User] u
       on al.userid = u.userid
     inner join BasicData..kindergarten k
       on u.kid = k.kid
     where 1=1 
      and al.actiondatetime >= CONVERT(VARCHAR(10),@bgndate,120)
      and al.actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
      and k.actiondate >= CONVERT(VARCHAR(10),@kidbgndate,120)  
      and k.actiondate < CONVERT(VARCHAR(10),DATEADD(DD,1,@kidenddate),120)
     group by k.kid,k.kname,Convert(varchar(10), k.actiondate, 120)
     order by COUNT(id) desc
END    

GO
