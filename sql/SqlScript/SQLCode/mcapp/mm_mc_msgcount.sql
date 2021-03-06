USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mc_msgcount]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--mm_mc_msgcount 12511, '2014-01-01', '2015-01-01'  
CREATE Procedure [dbo].[mm_mc_msgcount]  
@kid int,  
@begdate date,  
@enddate date  
as  
Select @enddate = DATEADD(dd, 1, @enddate)  
  
Select userid [用户ID], name [姓名], account [帐号], mobile [手机号], CAST('' as varchar(50)) [班级],   
       CAST(0 as int) [晨检短信(条)], CAST(0 as int) [入园短信(条)], CAST(0 as int) [离园短信(条)], CAST(0 as int) [其它短信(条)]  
       --,CAST(0 as int) [晨检时间与上传时间同一天的数量], CAST(0 as int) [晨检时间与上传数据时间不同一天的数量]  
  Into #U  
  From BasicData.dbo.[user]   
  Where deletetag = 1 and usertype = 0 and kid = @kid  
  
;With data1 as (  
Select recuserid, content  
  From sms.dbo.sms_message_yx_temp  
  Where sendtime between @begdate and @enddate and recuserid In (Select [用户ID] From #U)  
union all  
Select recuserid, content  
  From sms.dbo.sms_message_temp  
  Where sendtime between @begdate and @enddate and recuserid In (Select [用户ID] From #U)  
union all  
Select recuserid, content  
  From SMS_History.dbo.sms_message  
  Where sendtime between @begdate and @enddate and recuserid In (Select [用户ID] From #U)  
union all  
Select recuserid, content  
  From SMS.dbo.sms_message  
  Where sendtime between @begdate and @enddate and recuserid In (Select [用户ID] From #U)  
union all  
Select recuserid, content  
  From SMS.dbo.sms_message_yx  
  Where sendtime between @begdate and @enddate and recuserid In (Select [用户ID] From #U)  
), data2 as (  
Select recuserid,   
       SUM(Case When content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%') and content Like '%晨检%' Then 1 End) [晨检短信(条)],  
       SUM(Case When content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%') and content Like '%入园%' Then 1 End) [入园短信(条)],  
       SUM(Case When content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%') and content Like '%接离%' Then 1 End) [离园短信(条)],  
       SUM(Case When not (content Like '%小朋友家长%' and (content Like '%晨检%' Or content Like '%您的孩子于%')) Then 1 End) [其它短信(条)]  
  From data1  
  Group by recuserid  
)  
Update #U Set [晨检短信(条)] = Isnull(b.[晨检短信(条)], 0), [入园短信(条)] = Isnull(b.[入园短信(条)], 0), [离园短信(条)] = Isnull(b.[离园短信(条)], 0), [其它短信(条)] = Isnull(b.[其它短信(条)], 0)  
  From #U a, data2 b  
  Where a.[用户ID] = b.recuserid  
  
UPdate #U Set [班级] = c.cname  
  From #U a, BasicData.dbo.user_class b, BasicData.dbo.class c  
  Where a.[用户ID] = b.userid and b.cid = c.cid  
  
Select * From #U Order by [晨检短信(条)] + [入园短信(条)] + [离园短信(条)] + [其它短信(条)] Desc  
  
GO
