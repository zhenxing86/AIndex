USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsSendCount]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetSmsSendCount]
@bgndate datetime,
@enddate datetime,
@kid int
as
Set Nocount On

Select @bgndate = Convert(Varchar(10), @bgndate, 120)
Select @enddate = Convert(Varchar(10), dateadd(dd, 1, @enddate), 120)

Select Convert(Varchar(10), sendtime, 120) [日期], Count(*) [发送数量], Sum(Ceiling(Len(content) / 63.0)) [计费数量], 
       Isnull(Sum(Case When status = 1 Then 1 End), 0) [成功数量], Isnull(Sum(Case When status = 2 Then 1 End), 0) [失败数量]
  Into #curmonth
  From sms.dbo.sms_message_curmonth 
  Where sendtime >= @bgndate and sendtime < @enddate and status IN (1, 2) and Case When @kid > 0 Then kid Else @kid End = @kid
  Group by Convert(Varchar(10), sendtime, 120)

Select Convert(Varchar(10), sendtime, 120) [日期], Count(*) [发送数量], Sum(Ceiling(Len(content) / 63.0)) [计费数量], 
       Isnull(Sum(Case When status = 1 Then 1 End), 0) [成功数量], Isnull(Sum(Case When status = 2 Then 1 End), 0) [失败数量]
  Into #SMS_History
  From SMS_History.dbo.sms_message
  Where sendtime >= @bgndate and sendtime < @enddate and status IN (1, 2) and Case When @kid > 0 Then kid Else @kid End = @kid
  Group by Convert(Varchar(10), sendtime, 120)

Select Convert(Varchar(10), sendtime, 120) [日期], Count(*) [发送数量], Sum(Ceiling(Len(content) / 63.0)) [计费数量], 
       Isnull(Sum(Case When status = 11 Then 1 End), 0) [成功数量], Isnull(Sum(Case When status = 12 Then 1 End), 0) [失败数量]
  Into #yx_temp
  From sms.dbo.sms_message_yx_temp
  Where sendtime >= @bgndate and sendtime < @enddate and status IN (11, 12) and Case When @kid > 0 Then kid Else @kid End = @kid
  Group by Convert(Varchar(10), sendtime, 120)

;With Data as (
Select [日期], [发送数量], [计费数量], [成功数量], [失败数量] From #curmonth
Union all
Select [日期], [发送数量], [计费数量], [成功数量], [失败数量] From #SMS_History
)
Select '玄武' [通道], [日期], Sum([发送数量]) [发送数量], Sum([计费数量]) [计费数量], Sum([成功数量]) [成功数量], Sum([失败数量]) [失败数量]
  From Data
  Group by [日期]
Union all
Select '悦信' [通道], [日期], [发送数量], [计费数量], [成功数量], [失败数量] 
  From #yx_temp
  Order by [通道], [日期]

Drop Table #curmonth, #SMS_History, #yx_temp


GO
