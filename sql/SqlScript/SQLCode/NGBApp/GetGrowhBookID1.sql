USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowhBookID1]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-15  
-- Description: 初始化成长档案，growthbook表  
-- Memo:    
exec [GetGrowhBookID1] 718463, '2014-0'  
  SELECT * FROM BASICDATA..[USER] WHERE KID = 12511
 SELECT * FROM GrowthBook WHERE USERID = 295705 AND term = '2014-0'  
 SELECT * FROM GrowthBook WHERE USERID = 295765 AND term = '2014-0'  
select * from basicdata..class where kid=12511  

select * from GrowthBook where gbid = 4078683
select top(10) * from GrowthBook order by gbid desc



*/  
CREATE PROC [dbo].[GetGrowhBookID1]  
 @userid int,    
 @term varchar(6)    
AS    
BEGIN    
  
 SET @term='2014-0'  
   
 SET NOCOUNT ON    
 declare @gbid int,@cid int, @hbid int   
 declare @diaryid table(diaryid bigint, pagetplid int)    
  
 select @cid = cid   
  from BasicData..User_Child   
  where userid = @userid   
    
 select @gbid = gbid     
  from GrowthBook     
  where userid = @userid     
   and term = @term    
     
 IF @gbid IS NOT NULL    
  RETURN @gbid    
 ELSE    
 BEGIN     
  INSERT INTO GrowthBook(kid, grade, userid, term)    
  SELECT kid, grade, userid, @term    
   FROM BasicData.dbo.User_Child    
   where userid = @userid 
  IF @@ROWCOUNT = 0 RETURN -1   
  SET @gbid = ident_current('GrowthBook')  
   
	select  @gbid
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
   SELECT @gbid, c.pagetplid     
    from CET c   
  
  INSERT INTO page_public(diaryid,ckey,cvalue,ctype)    
   SELECT d.diaryid, ckey, cvalue, ctype     
    FROM page_public_tpl pp    
     inner join @diaryid d    
      on pp.pagetplid = d.pagetplid    
  
  select @hbid = hbid     
   from HomeBook     
   where cid = @cid     
    and term = @term    
  IF @hbid IS NULL    
  BEGIN    
   INSERT INTO HomeBook(kid, grade, cid, term)    
    SELECT kid, grade, cid, @term    
     FROM BasicData.dbo.class     
     where cid = @cid        
  END     
 END  
 RETURN @gbid     
END    

GO
