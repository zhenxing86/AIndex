USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_operation_record_bykid]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	YZ
-- Create date: 2014-5-20
-- Description:	手机端单园操作记录
-- [dbo].[rep_operation_record_bykid]'2014-5-19','2014-5-20',12511
-- =============================================
CREATE PROCEDURE [dbo].[rep_operation_record_bykid]
   @bgndate date,
   @enddate date,
   @kid int
AS
BEGIN
  select c.describe as 操作,
         r.operation as 操作ID,
         (case when r.appname = 1 then '老师' when r.appname in(97,98) then '园长' WHEN r.appname = 0 then '家长' END)as 用户类型,
         count(r.id) as 次数
    from [AppLogs].[dbo].[operation_record] r
      inner join [AppLogs].[dbo].[operation_config] c
        on r.operation = c.ID
    where r.operdate >= CONVERT(VARCHAR(10),@bgndate,120)
      and r.operdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
      and r.kid = @kid
    group by c.describe,r.operation,r.appname 
    order by 用户类型,count(r.id) desc
	SET NOCOUNT ON;

END

GO
