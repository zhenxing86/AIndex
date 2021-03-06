USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetGrowhBookID]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      Master谭            
-- Create date: 2013-08-15            
-- Description:   
只支持在园小朋友，获取gbid； 并且是最新学期  
如果gbid=0，初始化成长档案，growthbook表   
--1)下学期，初始化新成长档案,   
--2)上学期，需要升班后，才初始化新一本成长档案，否则取之前最近一本gbid。       
-- Memo:              
exec [GetGrowhBookID] 727676, '2014-0'            
  SELECT * FROM BASICDATA..[USER] WHERE KID = 12511          
 SELECT * FROM GrowthBook WHERE USERID = 564658 AND term = '2014-0'            
 SELECT * FROM GrowthBook WHERE USERID = 295765 AND term = '2014-0'            
select * from basicdata..class where kid=12511            
          
select * from GrowthBook where gbid = 4078683          
select top(10) * from GrowthBook order by gbid desc          
          
   [GetGrowhBookID] 90580,'2014-0'   
declare @gbid int    
exec @gbid =  NGBApp..[GetGrowhBookID] 653612,'2014-0'  
select  @gbid  

declare @gbid int,@cid int, @hbid int,@term varchar(6) 
 select uc.cid ,CommonFun.dbo.getCurrentTerm(uc.kid,GETDATE())  
  from basicdata..[User_Child] uc   
   inner join GrowthBook g   
    on uc.userid=g.userid   
     and g.term=@term  
  where uc.userid=653612 
  
  ngbapp..[GetGrowhBookID]  653612,'2014-1'
   SELECT * FROM ngbapp..GrowthBook WHERE USERID = 653612 
  
  
*/            
CREATE PROC [dbo].[GetGrowhBookID]            
 @userid int,              
 @term varchar(6) =null --值直接在数据库中获取            
AS              
BEGIN              
 SET NOCOUNT ON    
 declare @gbid int,@cid int, @hbid int             
 declare @diaryid table(diaryid bigint, pagetplid int)   
          
 select @cid = uc.cid,@term = CommonFun.dbo.fn_getCurrentTerm(uc.kid,GETDATE(),1)  
  from basicdata..[User_Child] uc   
  where uc.userid=@userid 
   
 select @gbid = gbid 
  from GrowthBook
   where userid = @userid
     and term=@term              
 IF @gbid IS NOT NULL              
  RETURN @gbid              
 ELSE              
 BEGIN     
  if exists(select 1 from basicdata..user_class_all where userid=@userid and term=@term and deletetag=1)  
  --1)下学期，需要升学期后，才初始化新成长档案,   
  --2)上学期，需要升班后，才初始化新一本成长档案  
  begin     
    INSERT INTO GrowthBook(kid, grade, userid, term)              
    SELECT kid, grade, userid, @term              
     FROM BasicData.dbo.User_Child              
     where userid = @userid           
             
    IF @@ROWCOUNT = 0 RETURN -1             
    SET @gbid = ident_current('GrowthBook')    
      
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
    RETURN @gbid     
 end          
 else  
 begin  
   select  @gbid = max(gbid)    
    from GrowthBook             
    where userid = @userid     
    group by userid        
              
   IF @gbid IS NOT NULL            
   RETURN @gbid            
   ELSE RETURN -1     
 end            
 END   
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'初始化成长档案，growthbook表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowhBookID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowhBookID', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetGrowhBookID', @level2type=N'PARAMETER',@level2name=N'@term'
GO
