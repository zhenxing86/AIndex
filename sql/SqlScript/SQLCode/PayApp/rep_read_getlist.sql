USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_read_getlist]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: yz
-- Create date: 2014-6-6
-- Description:	阅读计划成功购买情况统计
--[payapp].[dbo].[rep_read_getlist] '2014-1-1','2014-6-6'
-- =============================================
CREATE PROCEDURE [dbo].[rep_read_getlist]
@bgndate date,
@enddate date
AS
BEGIN
	SET NOCOUNT ON;
  select u.kid,
         k.kname,
         (case when r.PayType = 0 then '线上'else '线下'end) 支付方式,
         SUM(plus_amount)总金额
    from order_record r
      inner join BasicData..[user] u
        on r.userid = u.userid
      inner join BasicData..kindergarten k
        on u.kid = k.kid
    where r.actiondatetime >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    and r.[from]= '809'
    and [status] = 1
    group by u.kid,k.kname,r.PayType
    order by 支付方式,u.kid
    
END

GO
