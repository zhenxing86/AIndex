USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_D]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[mc_sms_D]
	@kid int,
	@bgndate datetime,
	@enddate datetime
	
AS
BEGIN
  SET NOCOUNT ON
  select CONVERT(VARCHAR(10),sendtime,120) cdate,
         datename(dw,sendtime) weekname,
         COUNT(CASE WHEN smstype in ('1','2')then 1 else null end) yzcnt,
         COUNT(CASE WHEN smstype in ('3','4','5','6','7')then 1 else null end) teacnt,
         COUNT(CASE WHEN smstype in ('8','9','10','11')then 1 else null end) stucnt
    from sms_mc
    where kid = @kid
        and sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
        and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
				and smstype in ('1','2','3','4','5','6','7','8','9','10','11')
    GROUP BY CONVERT(VARCHAR(10),sendtime,120), datename(dw,sendtime)
    ORDER BY 1
END


GO
