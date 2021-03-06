USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_table_symptom_List_ds]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-04-28  
-- Description: 过程用于生成 近期高发症状分析(学校)  
-- Memo:  
exec rep_table_symptom_List_ds @kid=12511,@checktime1=N'2014-09-08 00:00:00'
*/  
CREATE PROC [dbo].[rep_table_symptom_List_ds]  
 @kid  int,  
 @checktime1 datetime  
as  
BEGIN  
SET NOCOUNT ON  

 ;WITH CET AS  
 (  
 SELECT TOP 8  
    RIGHT(CONVERT(varchar(20),StartT,102),5) +'-'   
    +RIGHT( CONVERT(varchar(20),dateadd(dd,-1,EndT),102),5) weekdate,   
    StartT, EndT  
  FROM BasicData.dbo.WeekList   
  where StartT <= @checktime1  
  order by StartT desc  
 )    
 SELECT weekdate, 
        Case When CHARINDEX(',1,', ',' + b.zz + ',') > 0 Then 1 Else 0 End fs,
        Case When CHARINDEX(',3,', ',' + b.zz + ',') > 0 Then 1 Else 0 End hlfy,
        Case When CHARINDEX(',2,', ',' + b.zz + ',') > 0 Then 1 Else 0 End ks,
        Case When CHARINDEX(',4,', ',' + b.zz + ',') > 0 Then 1 Else 0 End lbt,
        Case When CHARINDEX(',6,', ',' + b.zz + ',') > 0 Then 1 Else 0 End fx,
        Case When CHARINDEX(',7,', ',' + b.zz + ',') > 0 Then 1 Else 0 End hy,
        Case When CHARINDEX(',8,', ',' + b.zz + ',') > 0 Then 1 Else 0 End szk,
        Case When CHARINDEX(',5,', ',' + b.zz + ',') > 0 Then 1 Else 0 End pz,
        Case When CHARINDEX(',10,', ',' + b.zz + ',') > 0 Then 1 Else 0 End fytx,
        Case When CHARINDEX(',9,', ',' + b.zz + ',') > 0 Then 1 Else 0 End jzj,
        Case When CHARINDEX(',11,', ',' + b.zz + ',') > 0 Then 1 Else 0 End parentstake,
        b.stuid userid, Cast(null as Int) cid, Cast(null as Varchar(50)) cname, Cast(null as Int) grade, CAST(0 as int)weakcount
   Into #T1
   From CET a Left Join stu_mc_day_zz b ON b.kid = @kid and b.checkdate >= a.StartT and b.checkdate < a.EndT;

  Update a Set cid = b.cid, cname = b.cname, grade = b.grade
    From #T1 a, BasicData..User_Child b
    Where a.userid = b.userid

  Delete #T1 Where grade In (38, 150) Or cid is null

 SELECT weekdate, SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy,   
   SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake      
  from #T1   
  GROUP BY weekdate  
 UNION   
 SELECT '合计', SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy,   
    SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake      
  from #T1  
   
SELECT weekdate, SUM(fs)fs, SUM(hlfy)hlfy, SUM(ks)ks, SUM(lbt)lbt, SUM(fx)fx, SUM(hy)hy,   
  SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake,   
  SUM(fs)+ SUM(hlfy)+ SUM(ks)+ SUM(lbt)+ SUM(fx)+ SUM(hy)+ SUM(szk)+ SUM(pz)+   
  SUM(fytx)+ SUM(jzj)+ SUM(parentstake)total,cid,cname,weakcount  
 from #T1   
 GROUP BY weekdate,cid,cname,weakcount  
 order by weekdate, cid  


 /*
 ;WITH CET AS  
 (  
 SELECT TOP 8  
    RIGHT(CONVERT(varchar(20),StartT,102),5) +'-'   
    +RIGHT( CONVERT(varchar(20),dateadd(dd,-1,EndT),102),5) weekdate,   
    StartT, EndT  
  FROM BasicData.dbo.WeekList   
  where StartT <= @checktime1  
  order by StartT desc  
 )    
 SELECT weekdate, 
        Case When CHARINDEX(',1,', ',' + result + ',') > 0 Then 1 Else 0 End fs,
        Case When CHARINDEX(',3,', ',' + result + ',') > 0 Then 1 Else 0 End hlfy,
        Case When CHARINDEX(',2,', ',' + result + ',') > 0 Then 1 Else 0 End ks,
        Case When CHARINDEX(',4,', ',' + result + ',') > 0 Then 1 Else 0 End lbt,
        Case When CHARINDEX(',6,', ',' + result + ',') > 0 Then 1 Else 0 End fx,
        Case When CHARINDEX(',7,', ',' + result + ',') > 0 Then 1 Else 0 End hy,
        Case When CHARINDEX(',8,', ',' + result + ',') > 0 Then 1 Else 0 End szk,
        Case When CHARINDEX(',5,', ',' + result + ',') > 0 Then 1 Else 0 End pz,
        Case When CHARINDEX(',10,', ',' + result + ',') > 0 Then 1 Else 0 End fytx,
        Case When CHARINDEX(',9,', ',' + result + ',') > 0 Then 1 Else 0 End jzj,
        Case When CHARINDEX(',11,', ',' + result + ',') > 0 Then 1 Else 0 End parentstake,
        cid, cname, CAST(0 as int)weakcount              
 into #T1  
  FROM CET c    
   left JOIN mcapp.dbo.rep_mc_child_checked_detail rm   
    on rm.checktime > = c.StartT   
    and rm.checktime < c.EndT  
     and ISNULL(rm.gradeid,0) Not In (38, 150)    
  WHERE rm.kid = @kid   
 --SELECT weekdate, ISNULL(fs,0)fs, ISNULL(hlfy,0)hlfy, ISNULL(ks,0)ks, ISNULL(lbt,0)lbt,   
 --  ISNULL(fx,0)fx, ISNULL(hy,0)hy, ISNULL(szk,0)szk, ISNULL(pz,0)pz, ISNULL(fytx,0)fytx,   
 --  ISNULL(jzj,0)jzj, ISNULL(parentstake,0)parentstake, cid, cname, CAST(0 as int)weakcount   
 --into #T1  
 -- FROM CET c    
 --  left JOIN mcapp.dbo.rep_mc_class_checked_sum rm   
 --   on rm.cdate > = c.StartT   
 --   and rm.cdate < c.EndT  
 --    and ISNULL(rm.gid,0) <> 38    
 -- WHERE rm.kid = @kid   
    
 SELECT weekdate, SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy,   
   SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake      
  from #T1   
  GROUP BY weekdate  
 UNION   
 SELECT '合计', SUM(fs)fs,SUM(hlfy)hlfy,SUM(ks)ks,SUM(lbt)lbt,SUM(fx)fx,SUM(hy)hy,   
    SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake      
  from #T1  
   
SELECT weekdate, SUM(fs)fs, SUM(hlfy)hlfy, SUM(ks)ks, SUM(lbt)lbt, SUM(fx)fx, SUM(hy)hy,   
  SUM(szk)szk, SUM(pz)pz, SUM(fytx)fytx, SUM(jzj)jzj, SUM(parentstake)parentstake,   
  SUM(fs)+ SUM(hlfy)+ SUM(ks)+ SUM(lbt)+ SUM(fx)+ SUM(hy)+ SUM(szk)+ SUM(pz)+   
  SUM(fytx)+ SUM(jzj)+ SUM(parentstake)total,cid,cname,weakcount  
 from #T1   
 GROUP BY weekdate,cid,cname,weakcount  
 order by weekdate, cid  
*/
END  

GO
