USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetCidTermByUserid]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-08-21      
-- Description: 读取家园联系册的数据   （并作初始化）     
-- Memo:      
[GetCidTermByUserid] 224899     
*/      
--      
CREATE PROC [dbo].[GetCidTermByUserid]      
 @userid int      
AS      
BEGIN    
    
  
 declare @cid table(cid int)    
 declare @gbid table(gbid int)         
 declare @diaryid table(diaryid bigint, pagetplid int)   
 declare @term nvarchar(6)  
   
 insert into @cid(cid)  
 select uc.cid   
   from BasicData.dbo.[user] u  
    inner join basicdata..user_class uc  
     on u.userid= uc.userid  
   where u.userid=@userid and kid>0 and deletetag=1 and usertype>0   
   
 Select @term = CommonFun.dbo.fn_getCurrentTerm(kid, GETDATE(), 1)   
   From BasicData.dbo.[user] u  
   Where u.userid=@userid and kid>0 and deletetag=1 and usertype>0   
  
Select kid, grade, userid,cid  
  Into #Child  
  From BasicData.[dbo].[User_Child_v]  
  Where cid In (Select cid From @cid)  
  
  Begin tran   
  
  INSERT INTO GrowthBook(kid, grade, userid, term)  
    output inserted.gbid into @gbid        
    Select kid, grade, userid, @term  
      From #Child  
  
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
    SELECT distinct kid, grade, cid, @term        
     FROM #Child  
    
  Commit tran   
    
 SELECT ca.cid,ca.cname,hb.term, hb.hbid    
  FROM HomeBook hb      
   inner join BasicData..class_all ca       
    on hb.cid = ca.cid and ca.deletetag=1 and hb.term=ca.term       
   inner join @cid c    
    on c.cid = ca.cid   
   order by term DESC,cname   
       
END   
  
GO
