USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[init_sms_notsend]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[init_sms_notsend]
as
Set Nocount On

Insert Into KWebCMS.dbo.Sms_Num(Kid, SmsNum, CrtDate)
  Select siteid, smsnum, getdate()
    From KWebCMS.dbo.site_config
    Where smsnum > 0

Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  Into #sms
  From sms.dbo.sms_message_yx_temp
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From sms.dbo.sms_message_temp
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From SMS_History.dbo.sms_message
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From SMS.dbo.sms_message
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From SMS.dbo.sms_message_yx
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From SMS.dbo.sms_message_curmonth
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))
union all
Select recuserid, recmobile, CONVERT(varchar(10), sendtime, 120) adddate, sendtime, writetime, 
       Case When content Like '%晨检%' Then '晨检' When content Like '%入园%' Then '入园' When content Like '%接离%' Then '离园' End content, status
  From SMS.dbo.sms_message_yx_mc
  Where sendtime > '2014-02-01' and (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%'))

Delete #sms Where content Is null

Select a.*, CommonFun.dbo.fn_RoleGet(b.sendSet,1) insend, CommonFun.dbo.fn_RoleGet(b.sendSet,2) outsend
  Into #mc
  From mcapp.dbo.stu_mc_day_raw a, mcapp..kindergarten b, ossapp..addservice c
  Where a.kid = b.kid and b.sendSet > 0 and a.adate > '2014-02-01' and a.adate between c.ftime And Isnull(c.ltime, GETDATE())
    and c.a7 = 806 and c.describe = '开通' and a.stuid = c.uid

Delete #mc Where outsend = 0 and datepart(hh, cdate) >= 16

if OBJECT_ID('mcapp.dbo.sms_notsend') is not null
  Drop Table mcapp.dbo.sms_notsend

Select a.*, commonfun.dbo.fn_cellphone(c.mobile) validmobile, Convert(Varchar(10), a.cdate, 120) dt
  Into mcapp.dbo.sms_notsend
  From #mc a, BasicData.dbo.[user] c
  Where Not Exists (Select * From #sms b Where a.stuid = b.recuserid and Convert(Varchar(10), a.cdate, 120) = b.adddate) 
    and a.stuid = c.userid

Drop Table #sms, #mc


GO
