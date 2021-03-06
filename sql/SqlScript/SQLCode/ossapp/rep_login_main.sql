USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_login_main]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:YZ
-- Create date:2014-6-30
-- Description:	云平台登陆统计总表
-- [dbo].[rep_login_main]'2014-3-1','2014-6-1'
-- =============================================
CREATE PROCEDURE [dbo].[rep_login_main]
@bgndate date,
@enddate date	

AS
BEGIN
	SET NOCOUNT ON;
  select COUNT(l.loginid)sumcnt,
       COUNT(distinct l.userid)sumcnt_p,
       COUNT(case when r.role_name = '管理员'then l.loginid else null end)admincnt,
       COUNT(distinct (case when r.role_name = '管理员'then l.userid else null end))admincnt_p,
       COUNT(case when r.role_name = '园长'then l.loginid else null end)enchoucnt,
       COUNT(distinct (case when r.role_name = '园长'then l.userid else null end))enchoucnt_p,
       COUNT(case when r.role_name = '老师'then l.loginid else null end)teacnt,
       COUNT(distinct (case when r.role_name = '老师'then l.userid else null end))teacnt_p,
       COUNT(case when u.usertype = 0 then l.loginid else null end)stucnt,
       COUNT(distinct (case when  u.usertype = 0 then l.userid else null end))stucnt_p

       
       
from AppLogs..log_login l
  left join BasicData..[user] u
     on l.userid = u.userid
  left join BasicData..kindergarten k
     on u.kid = k.kid
  left join KWebCMS..site_user su
     on u.userid = su.appuserid
  left join KWebCMS_Right.dbo.sac_user_role ur
     on ur.user_id = su.UID
  left join KWebCMS_Right.dbo.sac_role r  --以该表中的role_name作为判断用户身份的依据，而非user表中的usertype
     on ur.role_id = r.role_id
  
  where l.logindatetime >= CONVERT(VARCHAR(10),@bgndate,120)
    and l.logindatetime <CONVERT(VARCHAR(10),@enddate,120)
    and u.kid not in (12511,11061,22018,22030,22053,21935,22084)
    and ISNULL(k.kid,0)<>0
    

END

GO
