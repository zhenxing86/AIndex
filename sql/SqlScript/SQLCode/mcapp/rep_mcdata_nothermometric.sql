USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_nothermometric]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date:2014-04-04
-- Description:	只刷卡不测温的人数统计
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_nothermometric]
@bgndate date,
@enddate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select r.kid,k.kname,COUNT(case when r.tw IN ('0','00.00') then r.tw else null end)as 只刷卡未测温人数,COUNT(r.tw)as 总人数

       
  from mcapp..stu_mc_day_raw r
    inner join BasicData..kindergarten k
      on r.kid = k.kid
      
  where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
  group by r.kid,k.kname
  order by r.kid desc
END

GO
