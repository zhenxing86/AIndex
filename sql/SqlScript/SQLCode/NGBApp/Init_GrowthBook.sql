USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Init_GrowthBook]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date: 2013-08-15        
-- Description: 初始化成长档案，growthbook表        
-- Memo:          
exec Init_GrowthBook 55906, '2014-0'        
select * from basicdata..kid_term        
select * from basicdata..class where kid=12511        
*/        
CREATE PROC [dbo].[Init_GrowthBook]        
 @cid int,      
 @term nvarchar(10)      
AS        
BEGIN        
       
  declare @kid int      
  select @term=CommonFun.dbo.fn_getCurrentTerm(kid,GETDATE(),1),@kid=kid      
   from BasicData.dbo.class      
   where cid=@cid         
         
 SET NOCOUNT ON        
 --1)下学期，需要升学期后，才初始化新一本成长档案,       
 --2)上学期，需要升班后，才初始化新一本成长档案      
        
 declare @gbid table(gbid int)        
 declare @diaryid table(diaryid bigint, pagetplid int)        
         
  INSERT INTO GrowthBook(kid, grade, userid, term)        
   output inserted.gbid        
   into @gbid        
   SELECT @kid, c.grade, uca.userid, uca.term       
    FROM BasicData.dbo.user_class_all uca       
     inner join BasicData.dbo.class c     
      on uca.cid=c.cid     
       and c.deletetag=1      
     inner join BasicData..[user] u       
      on u.userid=uca.userid and u.deletetag=1 and       
       u.usertype = 0      
     where uca.cid = @cid and uca.term = @term and uca.deletetag=1      
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
         
  if @@ROWCOUNT=0 return -1  --user_clas_all\class_all还没有数据（即还没切换学期成功，即使学期已经开始），不初始化成长档案和家园联系册      
            
  DECLARE @hbid int        
          
  select @hbid = hbid         
   from HomeBook         
   where cid = @cid         
    and term = @term        
  IF @hbid IS NOT NULL        
   RETURN @hbid        
  ELSE        
  BEGIN        
   INSERT INTO HomeBook(kid, grade, cid, term)        
    SELECT kid, grade, cid, term        
     FROM BasicData.dbo.class_all         
     where cid = @cid and term=@term and deletetag=1      
   RETURN ident_current('HomeBook')          
  END         
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'初始化成长档案，growthbook表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Init_GrowthBook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Init_GrowthBook', @level2type=N'PARAMETER',@level2name=N'@cid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Init_GrowthBook', @level2type=N'PARAMETER',@level2name=N'@term'
GO
