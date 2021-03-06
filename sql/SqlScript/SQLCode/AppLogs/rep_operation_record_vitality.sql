USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_operation_record_vitality]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	YZ
-- Create date: 2014-5-20
-- Description:	手机端全局用户活跃度分析
-- [dbo].[rep_operation_record_vitality]'2014-5-20','2014-5-20'
-- =============================================
CREATE PROCEDURE [dbo].[rep_operation_record_vitality]
   @bgndate date,
   @enddate date
AS
BEGIN
    select r.kid,
           k.kname 幼儿园,
           COUNT(r.id)操作总数,
           COUNT(case when r.appname = 1 then r.id else null end) as 老师端操作数,
           COUNT(case when r.appname in(97,98) then r.id else null end) as 园长端操作数,
           COUNT(case when r.appname = 0 then r.id else null end) as 家长端操作数
    from AppLogs..operation_record r
      inner join BasicData..kindergarten k
        on r.kid = k.kid
    where r.operdate >= CONVERT(VARCHAR(10),@bgndate,120)
      and r.operdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
   
    group by r.kid,
           k.kname
    order by COUNT(r.id) desc
	SET NOCOUNT ON;

END

GO
