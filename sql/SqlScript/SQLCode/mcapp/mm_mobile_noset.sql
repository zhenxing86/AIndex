USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mobile_noset]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[mm_mobile_noset]
as
set nocount on 

Select a.kid [幼儿园ID], c.kname [幼儿园], d.name [发展人], 
       Isnull(SUM(Case When b.roletype = 1 Then 1 End), 0) [园长配置人数], 
       Isnull(SUM(Case When b.roletype = 2 Then 1 End), 0) [校医配置人数],
       Isnull(SUM(Case When b.roletype = 3 Then 1 End), 0) [老师配置人数],
       CAST(Null as Varchar(1000)) [备注]
  Into #sms_man
  From blogapp..permissionsetting a Left Join mcapp.dbo.sms_man_kid b On a.kid = b.kid
                                    Left Join ossapp.dbo.kinbaseinfo c On a.kid = c.kid
                                    Left Join ossapp.dbo.users d On c.developer = d.ID
  Where a.ptype = 90 and c.deletetag = 1 and a.kid not in (12511,11061,22018,22030,22053,21935,22084)
  Group by a.kid, c.kname, c.infofrom, d.name

Update #sms_man Set [备注] = Case When num - [老师配置人数] <= 0 Then '' Else '还有' + Cast(num - [老师配置人数] as Varchar) + '个班级未配置接收老师' End
  From #sms_man a, (Select a.kid, COUNT(*) num
                      From BasicData.dbo.class a
                      Where Exists (Select b.cid From BasicData.dbo.user_class b 
                                      Where a.cid = b.cid 
                                      Group by b.cid
                                      Having COUNT(*) > 2)
                        and a.deletetag = 1
                      Group by a.kid) b
  Where a.[幼儿园ID] = b.kid

Update #sms_man Set [备注] = Case When [园长配置人数] = 0 Then '园长未配置,' Else '' End + Case When [校医配置人数] = 0 Then '校医未配置,' Else '' End + ISNULL([备注], '')

Select * From #sms_man

Drop Table #sms_man


GO
