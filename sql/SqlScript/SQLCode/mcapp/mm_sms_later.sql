USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_sms_later]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--mm_sms_later '2014-06-01', '2014-07-01', 1
CREATE Procedure [dbo].[mm_sms_later]
@begdate datetime,
@enddate datetime,
@minute Int
as
set nocount on 

Select b.kid [幼儿园ID], c.kname [幼儿园], d.name [发展人], b.userid [用户ID], b.name [姓名], a.mobile [电话], 
       a.cdate [刷卡时间], a.adate [上传时间], a.sendtime [发送时间]
  From dbo.stu_mc_day_raw_monitor a Left Join BasicData.dbo.[user] b On a.stuid = b.userid
                                    Left Join ossapp.dbo.kinbaseinfo c On b.kid = c.kid
                                    Left Join ossapp.dbo.users d On c.developer = d.ID
  Where DATEDIFF(mi, a.adate, a.sendtime) >= @minute and a.cdate >= @begdate and a.cdate <= Dateadd(dd, 1, @enddate)
    and b.kid not in (12511,11061,22018,22030,22053,21935,22084)

GO
