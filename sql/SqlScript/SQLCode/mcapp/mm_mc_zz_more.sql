USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mc_zz_more]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--mm_mc_zz_more '2014-06-01', '2014-07-01'
CREATE Procedure [dbo].[mm_mc_zz_more]    
@begdate datetime,    
@enddate datetime    
as    
set nocount on     
    
Select Convert(Varchar(10), cdate, 120) dt, a.kid, stuid,     
       Case When Sum(Case when ',' + zz + ',' like '%,1,%' then 1 End) > 0 Then 1 Else 0 End [发烧],    
       Case When Sum(Case when ',' + zz + ',' like '%,2,%' then 1 End) > 0 Then 1 Else 0 End [咳嗽],    
       Case When Sum(Case when ',' + zz + ',' like '%,3,%' then 1 End) > 0 Then 1 Else 0 End [喉咙发炎],    
       Case When Sum(Case when ',' + zz + ',' like '%,4,%' then 1 End) > 0 Then 1 Else 0 End [流鼻涕],    
       Case When Sum(Case when ',' + zz + ',' like '%,5,%' then 1 End) > 0 Then 1 Else 0 End [皮疹],    
       Case When Sum(Case when ',' + zz + ',' like '%,6,%' then 1 End) > 0 Then 1 Else 0 End [腹泻],    
       Case When Sum(Case when ',' + zz + ',' like '%,7,%' then 1 End) > 0 Then 1 Else 0 End [红眼病],    
       Case When Sum(Case when ',' + zz + ',' like '%,8,%' then 1 End) > 0 Then 1 Else 0 End [重点观察],    
       Case When Sum(Case when ',' + zz + ',' like '%,9,%' then 1 End) > 0 Then 1 Else 0 End [剪指甲],    
       Case When Sum(Case when ',' + zz + ',' like '%,10,%' then 1 End) > 0 Then 1 Else 0 End [服药提醒],    
       Case When Sum(Case when ',' + zz + ',' like '%,11,%' then 1 End) > 0 Then 1 Else 0 End [家长带回]    
  Into #mc    
  From mcapp.dbo.stu_mc_day_raw a    
  Where a.cdate >= @begdate and a.cdate <= Dateadd(dd, 1, @enddate) and kid not in (12511,11061,22018,22030,22053,21935,22084)
  Group by Convert(Varchar(10), cdate, 120), a.kid, stuid    
    
Select dt [日期], kid [幼儿园ID], CAST('' as Varchar(100)) [幼儿园], CAST('' as Varchar(100)) [发展人],     
       CAST(0 as Int) [幼儿园人数], CAST(0 as Int) [晨检人数],     
       SUM([发烧]) [发烧], SUM([咳嗽]) [咳嗽], SUM([喉咙发炎]) [喉咙发炎], SUM([流鼻涕]) [流鼻涕],    
       SUM([皮疹]) [皮疹], SUM([腹泻]) [腹泻], SUM([红眼病]) [红眼病], SUM([重点观察]) [重点观察],     
       SUM([剪指甲]) [剪指甲], SUM([服药提醒]) [服药提醒], SUM([家长带回]) [家长带回]    
  Into #mczz    
  From #mc    
  Group by dt, kid    
    
Update a Set [幼儿园] = c.kname, [发展人] = d.name    
  From #mczz a, ossapp.dbo.kinbaseinfo c, ossapp.dbo.users d    
  Where a.[幼儿园ID] = c.kid and c.developer = d.ID    
    
Update a Set [幼儿园人数] = b.[幼儿园人数]    
  From #mczz a, (Select kid, Count(*) [幼儿园人数] From basicdata.dbo.[user] Where usertype = 0 and deletetag = 1 Group by kid) b    
  Where a.[幼儿园ID] = b.kid    
    
Update a Set [晨检人数] = b.[晨检人数]    
  From #mczz a, (Select kid, Count(Distinct stuid) [晨检人数] From #mc Group by kid) b    
  Where a.[幼儿园ID] = b.kid    
    
Select * From #mczz     
  Where [发烧] + [咳嗽] + [喉咙发炎] + [流鼻涕] + [皮疹] + [腹泻] + [红眼病] + [重点观察] + [剪指甲] + [服药提醒] + [家长带回] > 0    
  Order by [发烧] + [咳嗽] + [喉咙发炎] + [流鼻涕] + [皮疹] + [腹泻] + [红眼病] + [重点观察] + [剪指甲] + [服药提醒] + [家长带回] Desc    

Drop Table #mczz    


GO
