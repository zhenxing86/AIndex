USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetStatementDetail]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  于璋  
-- Create date: 2014-03-08  
-- Description: 阅读计划结算单细节列表获取  
--[PayApp]..[GetStatementDetail] 1897,'2011-01-01','2015-01-01', '线下', '已结算', 0, 0
-- =============================================  
CREATE PROCEDURE [dbo].[GetStatementDetail]  
@kid int,      
@Term Varchar(50),
@PayType Varchar(50),
@status Varchar(50),
@page int,
@size int   
  
AS  
SET NOCOUNT ON;  
------------------------------------------  
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

DECLARE @fromstring NVARCHAR(2000)      
SET @fromstring =       
'payapp..order_record r Inner Join BasicData..[user] u On r.userid = u.userid 
                        Left Join BasicData..user_class uc On uc.userid = u.userid 
                        Left Join BasicData..class c On uc.cid = c.cid  
 Where r.[status] <> -1 and r.[from] = ''809''
   and r.actiondatetime >= ''' + CONVERT(VARCHAR(10),@bgnmonth,120) + ''' 
   and r.actiondatetime < ''' + CONVERT(VARCHAR(10),DATEADD(DD,1,@endmonth),120) + '''
   and r.PayType = ' + Cast(Case When @PayType = '线上' Then 0 Else 1 End as NVARCHAR) + '
   and r.status = ' + Cast(Case When @status = '已结算' Then 1 Else 0 End as NVARCHAR) + '
   and u.kid = ' + CAST(@kid as NVARCHAR)
   
exec sp_MutiGridViewByPager      
@fromstring = @fromstring,      --数据集      
@selectstring =       
'r.orderid ,c.cname,u.name,r.plus_amount amount,r.actiondatetime dotime,  
(case when r.Status = 1 then ''已完成'' else ''未完成'' end) status,  
(case when r.[PayType] = 1 then ''现金'' else ''网银'' end) paytype',      --查询字段      
@returnstring =       
'orderid,cname,name,amount,dotime,[status],paytype',      --返回字段      
@pageSize = @Size,                 --每页记录数      
@pageNo = @page,                     --当前页      
@orderString = 'r.orderid',          --排序条件      
@IsRecordTotal = 1,             --是否输出总记录条数      
@IsRowNo = 0,           --是否输出行号      
@D1 = @kid,
@T1 = @bgnmonth,
@T2 = @endmonth,
@S1 = @PayType,
@S2 = @status



GO
