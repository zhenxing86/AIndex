USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mc_nosms]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--mm_mc_nosms '2014-06-01', '2014-07-01'
CREATE Procedure [dbo].[mm_mc_nosms]
@begdate datetime,
@enddate datetime
as
set nocount on 

;With Data as (
Select Distinct dt, c.kid, c.userid, c.name, c.account, c.mobile, insend, outsend, 
       Case When commonfun.dbo.fn_cellphone(c.mobile) <> 1 Then '号码没通过检查'            
            When Convert(Varchar(10), cdate, 120) <> Convert(Varchar(10), adate, 120) Then '不在当天上传' 
            Else '其它原因(可能是数据上传当天开通的VIP)' End Reason
  From sms_notsend a, BasicData.dbo.[user] c
  Where a.stuid = c.userid and a.dt >= @begdate and a.dt <= @enddate and c.kid not in (12511,11061,22018,22030,22053,21935,22084)
)
Select a.dt [日期], a.kid [幼儿园ID], c.kname [幼儿园], d.name [发展人], a.userid [用户ID], a.name [姓名], a.mobile [手机号], 
       Case When insend = 1 Then '√' Else '' End [是否配置入园短信], Case When outsend = 1 Then '√' Else '' End [是否配置离园短信], 
       stuff(CommonFun.dbo.sp_GetSumStr('+' + Reason), 1, 1, '') [备注]
  From Data a Left Join ossapp.dbo.kinbaseinfo c On a.kid = c.kid
              Left Join ossapp.dbo.users d On c.developer = d.ID
  Group by a.dt, a.kid, a.userid, a.name, a.account, a.mobile, insend, outsend, c.kname, d.name
  Order by a.dt, a.kid, a.userid


GO
