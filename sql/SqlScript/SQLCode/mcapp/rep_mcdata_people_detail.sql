USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_people_detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-4-4
-- Description:	查询某幼儿园晨检人数变化情况
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_people_detail]
@bgndate date,
@enddate date,
@kid int
AS
BEGIN
	SET NOCOUNT ON 


select cast(DATEADD(DD,n-1,@bgndate)as varchar(10)) as 日期, COUNT(r.tw) as 晨检人数
  from CommonFun..Nums100 n
  left join mcapp..stu_mc_day_raw r
    on r.cdate >= DATEADD(DD,n-1,@bgndate) 
    and r.cdate < DATEADD(DD,n,@bgndate)
  where n < = DATEDIFF(DD,@bgndate,@enddate)
    and r.kid = @kid
    GROUP BY n
    ORDER BY n


END

GO
