USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[MobileLog_Getlist]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[MobileLog_Getlist]
@bgndate date,
@enddate date,
@page Int,
@Size Int,
@kid Int = 0 
as
Set Nocount On;

With cte1 as (
Select userid, Convert(Varchar(10), happendate, 120) happendate, newmobile, oldmobile, Row_Number() Over(Partition by userid Order by happendate Desc) RowNo
  From AppLogs.dbo.Mobile 
  Where happendate Between @bgndate and dateadd(dd, 1, @enddate) and kid = Case When @kid = 0 Then kid else @kid End
), cte2 as (
Select Count(*) Over() Total, happendate, userid, newmobile, oldmobile, Row_Number() Over(Order by happendate) RowNo
  From cte1 
  Where RowNo = 1
)
Select Total, happendate, userid, newmobile, oldmobile 
  Into #Mobile 
  from cte2 
  Where @page = -1 Or (RowNo > (@page - 1) * @Size and RowNo <= @page * @Size)

Select a.Total, a.happendate, kid, b.account, b.name, a.newmobile, a.oldmobile
  From #Mobile a, basicdata.dbo.[user] b
  Where a.userid = b.userid


GO
