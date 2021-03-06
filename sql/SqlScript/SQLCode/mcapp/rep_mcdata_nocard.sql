USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_nocard]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date:2014-04-04
-- Description:	只测温不刷卡的人数统计
--mcapp..rep_mcdata_nocard '2014-4-1','2014-4-4'
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_nocard]
@bgndate date,
@enddate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select r.kid,k.kname,COUNT(case when r.card = '1111111111' then r.card else null end) as 只测温未刷卡人数,COUNT(r.card)as 总人数

       
  from mcapp..stu_mc_day_raw r
    inner join BasicData..kindergarten k
      on r.kid = k.kid
      
  where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
  group by r.kid,k.kname
  having COUNT(case when r.card = '1111111111' then r.card else null end) <> 0
  order by r.kid desc
END

GO
