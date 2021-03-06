USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[rep_operation_record_login_teacher]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	YZ
-- Create date: 2014-5-20
-- Description:	老师端登陆人数变化
-- [dbo].[rep_operation_record_login_teacher]'2014-5-1','2014-5-20'
-- =============================================
CREATE PROCEDURE [dbo].[rep_operation_record_login_teacher]
   @bgndate date,
   @enddate date
AS
BEGIN
  SET NOCOUNT ON;
  select cast(DATEADD(DD,n-1,@bgndate)as varchar(10)) as 日期, COUNT(r.id) as 登陆人数
  from CommonFun..Nums100 n
  left join AppLogs..operation_record r
    on r.operdate >= DATEADD(DD,n-1,@bgndate) 
    and r.operdate < DATEADD(DD,n,@bgndate)
  where n < = DATEDIFF(DD,@bgndate,@enddate)+1
    --and r.kid = @kid
    and r.operation = 1
    and r.appname = 1
    GROUP BY n
    ORDER BY n
END

GO
