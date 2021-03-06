USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowthBookV2]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:      Master谭          
-- Create date: 2013-08-21          
-- Description: 读取成长档案的数据          
-- Memo:use ngbapp          
select * from growthbook where userid=295765          
[GetGrowthBookV2] 4096          
*/          
--          
CREATE PROC [dbo].[GetGrowthBookV2]          
 @gbid int          
AS          
BEGIN          
 SET NOCOUNT ON          
 DECLARE @hbid int, @userid int, @cgid INT, @Cardurl varchar(100),       
     @bgndate datetime ,@enddate datetime, @Cardst varchar(50),       
     @kid int, @birthday datetime, @gtype int, @term varchar(6)          
 SELECT @hbid = hb.hbid, @userid = gb.userid, @kid = gb.kid, @term = gb.term,          
     @gtype = isnull(g.gtype, CASE CommonFun.dbo.fn_age(u.birthday) WHEN 2 THEN 4 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END)           
  FROM GrowthBook gb          
   LEFT join BasicData..grade g          
    on gb.grade = g.gid          
   inner join BasicData..user_class uc           
    on gb.userid = uc.userid          
   inner join BasicData..class c           
    on uc.cid = c.cid          
   inner join HomeBook hb          
    on hb.cid = c.cid          
    and hb.term = gb.term          
   inner join BasicData..[user] u          
    on u.userid = gb.userid          
  WHERE gb.gbid = @gbid          
  select @bgndate = bgndate, @enddate = enddate       
  from commonfun.dbo.getTerm_bgn_endByTerm(@term,@kid)        
 --取成长卡片信息，地址，状态          
 /*========================================================*/          
 BEGIN             
 declare @curdate datetime        
 if @enddate < GETDATE()      
 set @curdate = @bgndate      
 ELSE       
 set @curdate = GETDATE()        
         
 IF(DAY(@curdate)=1)        
 SET @CURDATE = @curdate        
         
  SELECT @cgid = cg.cgid, @Cardurl = cg.url           
   FROM GrowthBook gb          
    inner join CardSet cs           
     on @gtype = cs.gtype        
     and cs.ShowMonth = month(@curdate)              
   inner join CardGroup cg           
    on cs.cgid = cg.cgid          
   where gb.gbid = @gbid            
                    
  create table #TA(orderno int primary key, st varchar(50))          
  INSERT INTO #TA(orderno, st)          
  select c.orderno,           
      CASE WHEN a.cardid IS not null And c.ShowDay <= DAY(@curdate) then '2'           
      WHEN c.ShowDay <= DAY(@curdate) THEN '1' ELSE '0' END st          
   from cards c           
    LEFT JOIN          
     (          
      SELECT top(1) cardid           
       FROM CardHighlightSet ch           
       WHERE ch.cgid = @cgid           
        and HighlightDay <= DAY(@curdate)           
       order by HighlightDay desc          
     )a          
     on c.cardid = a.cardid          
   where c.cgid = @cgid            
   ORDER BY c.orderno          
            
  select @Cardst = STUFF(commonfun.dbo.sp_GetSumStr(','+st),1,1,'')          
   from #TA          
 END          
 /*========================================================*/          
            
 --1、成长档案基础信息、填写周期配置数据集,（卡片地址，显示月，日），期末总评，发展评估          
 SELECT gb.kid, k.kname, gb.grade, uc.cid, uc.cname, gb.term,           
     ISNULL(hb.Teacher,dbo.GetHomeBookTercher(hb.cid))Teacher,          
     hb.Foreword, hb.ForewordPic, hb.ClassNotice, hb.ClassPic,          
     k.NGB_Descript, k.NGB_Pic, fm.Monadvset, fm.cellset, gb.TeaWord,          
     gb.Height, gb.Weight, gb.Eye, gb.Blood, gb.Tooth, gb.DocWord,          
     gb.MyWord, gb.ParWord, gb.FamilyPic,           
     isnull(gb.Dadname,dbo.GetFamilyInfo(gb.userid,'Dadname'))Dadname,          
     isnull(gb.MomName,dbo.GetFamilyInfo(gb.userid,'MomName'))MomName,           
     gb.MomJob, gb.ParWish, gb.DevEvlPoint,@Cardurl Cardurl, @Cardst Cardst, fm.celltype,uc.name username          
     ,case when fm.hbModList like '%AdvSummary%' then 1 else 0 end as isAdvSummary,fm.hbModList          
  FROM GrowthBook gb          
   inner join BasicData..kindergarten k          
    on gb.kid = k.kid          
   inner join BasicData..[User_Child] uc           
    on gb.userid = uc.userid          
   inner join HomeBook hb          
    on hb.cid = uc.cid          
    and hb.term = gb.term          
   CROSS apply(select * from dbo.fn_ModuleSet(gb.kid,gb.term))fm             
  WHERE gb.gbid = @gbid          
           
 --2、日历           
 DECLARE @DF AS INT;          
  SET @DF = @@DATEFIRST;          
  SET DATEFIRST 7;           
           
  SELECT cs.ShowMonth, c.ShowDay           
  INTO #T          
  FROM CardSet cs           
   inner join cards c           
   on cs.cgid = c.cgid           
  WHERE cs.gtype = @gtype          
  ORDER BY cs.ShowMonth, c.ShowDay           
            
  SELECT ShowMonth, STUFF(CommonFun.dbo.sp_GetSumStr(','+CAST(ShowDay AS VARCHAR(10))),1,1,'')iscard          
  INTO #T1          
  FROM #T          
  GROUP BY ShowMonth          
           
  SELECT REPLACE(CONVERT(varchar(7),ca.StartT,120),N'-0','-') title, firstday = datepart(dw,ca.StartT) - 1,          
  DATEDIFF(DD,ca.StartT,ca.EndT)totalday, t.iscard          
  FROM CommonFun.[dbo].getTerm_bgn_endByTerm(@term,@kid)be          
  cross apply           
   (          
   select *           
    from CommonFun.dbo.fn_MonthList(1,0)           
    where StartT >= be.bgndate           
     and StartT <= be.enddate          
   )ca          
  LEFT JOIN #T1 t on month(ca.StartT) = t.ShowMonth          
  SET DATEFIRST @DF;            
           
 --3、成长日记目录          
 ;with cet as          
 (          
 select gbid, CASE WHEN pictype =1 then 20 else 22 end pagetplid, photoid diaryid, updatetime crtDate, deletetag, 0 Author          
  from tea_UpPhoto          
  union          
 SELECT d.gbid, d.pagetplid, d.diaryid, d.crtDate,deletetag ,Author          
  FROM diary d           
 )          
 SELECT d.gbid, d.pagetplid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType,           
     d.crtDate, pt.tpltype, pt.url, pt.lazy          
  FROM cet d           
   left join PageTpl pt           
    on d.pagetplid = pt.pagetplid          
   LEFT JOIN BasicData..[user] u          
    on u.userid = d.Author          
  where d.gbid = @gbid and d.deletetag=1          
  order by d.crtDate          
           
 --4、宝宝档案,生活剪影，手工作品，等成长日记模板的数据           
 SELECT gbid, d.pagetplid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.CrtDate, pp.ckey, pp.cvalue, pp.ctype          
  FROM diary d           
   inner join page_public pp          
   on pp.diaryid = d.diaryid          
  LEFT JOIN BasicData..[user] u          
   on u.userid = d.Author          
  where d.gbid = @gbid          
            
 --5、幼儿表现数据集          
 select d.gbid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.pagetplid, @userid userid, pc.title,           
     pc.TeaPoint, pc.TeaWord, pc.ParPoint, pc.ParWord           
  FROM diary d          
   inner join page_cell pc          
    on pc.diaryid = d.diaryid          
  LEFT JOIN BasicData..[user] u          
   on u.userid = d.Author          
  where d.gbid = @gbid          
  order by pc.title          
          
 --6、在园表现观察目标数据集           
 SELECT hbid,title,target           
  FROM celltarget          
  WHERE hbid = @hbid          
            
  --7、每月进步数据集          
 select d.gbid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.pagetplid, @userid userid,           
     pm.title, pm.MyPic, pm.TeaWord, pm.ParWord, pm.MyWord          
  FROM diary d             
   inner join page_month_sec pm          
    on pm.diaryid = d.diaryid          
  LEFT JOIN BasicData..[user] u          
   on u.userid = d.Author          
  where d.gbid = @gbid           
  order by pm.title           
          
  --8、月观察与评价目标：             
 SELECT mt.months, mt.target           
  FROM GrowthBook gb           
   inner join BasicData..grade g          
    on gb.grade=g.gid          
   inner join monthtarget mt           
    on g.gtype = mt.grade           
    and CAST(RIGHT(gb.term,1) AS INT) = mt.semester          
  WHERE gb.gbid = @gbid          
           
            
  --9、月观察与评价            
 select d.gbid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.pagetplid, @userid userid,           
     pm.months, pm.TeaPoint, pm.ParPoint          
  FROM diary d          
   inner join page_month_evl pm          
    on pm.diaryid = d.diaryid          
  LEFT JOIN BasicData..[user] u          
   on u.userid = d.Author          
  where d.gbid = @gbid          
  order by pm.months          
       
--10、生活剪影手工作品          
 select photoid, photo_desc,m_path,updatetime,pictype           
  from tea_UpPhoto           
   where gbid=@gbid and deletetag=1     
    
--11、幼儿表现目录        
 select pos,title from dbo.fn_GetCellsetList(@term,@kid)    
--12、每月进步/观察评价目录    
 select pos,title,months from dbo.fn_GetMonAdvList(@term,@kid)            
END 


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取成长档案的数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookV2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowthBookV2', @level2type=N'PARAMETER',@level2name=N'@gbid'
GO
