USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetStatementMainForEnchou]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  于璋      
-- Create date: 2014-03-08      
-- Description:园长用阅读计划结算总体情况      
-- =============================================      
CREATE PROCEDURE [dbo].[GetStatementMainForEnchou]      
@kid int,      
@Term Varchar(50)
AS      
SET NOCOUNT ON;      

Declare @bgnmonth date, @endmonth date      
Select @bgnmonth = bgndate, @endmonth = enddate From BasicData.dbo.kid_term Where kid = @kid and term = @Term

if @bgnmonth is Null or @endmonth is Null
begin
  if CHARINDEX('-1', @Term ) > 0
  begin
    Select @bgnmonth = Cast(LEFT(@Term, 4) + '-09-01' as date)
    Select @endmonth = sdate From BasicData.dbo.Springday Where Term = Cast(Cast(LEFT(@Term, 4) as Int) + 1 as Varchar) + '-0'
  end
  else begin
    Select @bgnmonth = sdate From BasicData.dbo.Springday Where Term = @Term
    Select @endmonth = Cast(LEFT(@Term, 4) + '-09-01' as date)
  end
end

Select @Term dotime,
       --Left(@Term, 4) + '年' + Case when RIGHT(@Term, 1) = '1' Then '上学期' Else '下学期' End dotime, 
       Case When a.PayType = 0 Then '线上' Else '线下' End fromcode, 
       Convert(Varchar, SUM(Cast(a.plus_amount as Numeric(9, 2)))) as amount, 
       COUNT(a.orderid) people, 
       Convert(Varchar,COUNT(a.OrderID) * Isnull(k.ShareMod, 0)) as finalamount, 
       Case When a.status = 1 Then '已结算' Else '未结算' End [结算状态]
  From payapp.dbo.order_record a, BasicData..[User] u, BasicData..kindergarten k
  Where a.[from] = '809' and a.[status] <> -1 and a.userid = u.userid and u.kid = k.kid and u.kid = @kid
    and a.actiondatetime >= CONVERT(VARCHAR(10),@bgnmonth,120) and a.actiondatetime < CONVERT(VARCHAR(10),DATEADD(DD,1,@endmonth),120)      
  Group by Case When a.PayType = 0 Then '线上' Else '线下' End, 
           Case When a.status = 1 Then '已结算' Else '未结算' End, k.ShareMod


--[payapp].[dbo].[GetStatementMainForEnchou] 1897,'2014-0'  
  

GO
