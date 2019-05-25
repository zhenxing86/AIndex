use NGBApp
go
/*------------------------------------  
-- Author:      xie  
-- Create date: 2014-07-02   
-- Description: 设置所有幼儿园的当前学期  
-- Paradef:    
  
-- Memo:   
   
 Init_GrowthBook_Batch '2014-1'
------------------------------------*/  
CREATE PROC [dbo].[Init_GrowthBook_Batch]      
@term nvarchar(6)='2014-1'
as
Begin tran   
declare @gbid table(gbid int)      
 declare @diaryid table(diaryid bigint, pagetplid int)      
  
  select kid into #kid from ossapp..kinbaseinfo where status in ('正常缴费','试用期','正式使用') and deletetag=1

  INSERT INTO GrowthBook(kid, grade, userid, term)      
   output inserted.gbid      
   into @gbid      
   SELECT c.kid, c.grade, uca.userid, uca.term     
    FROM BasicData.dbo.user_class_all uca     
     inner join BasicData.dbo.class c   
      on uca.cid=c.cid   
       and c.deletetag=1  
     inner join #kid k on k.kid=c.kid  
     inner join BasicData..[user] u     
      on u.userid=uca.userid and u.deletetag=1 and     
       u.usertype = 0    
     where uca.term = @term and uca.deletetag=1    
 ;WITH CET AS      
 (      
  SELECT 11 AS pagetplid      
  UNION ALL      
  SELECT 12      
  UNION ALL      
  SELECT 13      
 )          
   INSERT INTO diary(gbid,pagetplid)      
    output inserted.diaryid, inserted.pagetplid      
    into @diaryid(diaryid, pagetplid)      
    SELECT g.gbid, c.pagetplid       
     from CET c cross join @gbid g      
              
   INSERT INTO page_public(diaryid,ckey,cvalue,ctype)      
    SELECT d.diaryid, ckey, cvalue, ctype       
     FROM page_public_tpl pp      
      inner join @diaryid d      
       on pp.pagetplid = d.pagetplid      
       
   INSERT INTO HomeBook(kid, grade, cid, term)      
    SELECT ca.kid, grade, cid, term      
     FROM BasicData.dbo.class_all ca
      inner join #kid k on ca.kid=k.kid and term=@term       
     where term=@term and ca.deletetag=1 and not exists(
      select *from homebook hb where hb.cid=ca.cid and hb.term=ca.term
     )  
   
   drop table #kid
    Commit tran 
    
    
    select count(userid),userid,term from ngbapp..GrowthBook 
    group by userid,term 
    having COUNT(userid)>1