USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetDiaryByPageV2]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie    
-- Create date: 2014-08-22      
-- Description: 分页读取成长日记的列表(手机Web版)      
-- Memo:use ngbapp      
exec GetDiaryByPageV2 295765, 2151, 1    
exec GetDiaryByPage 295765, 2151, 1   
*/      
--      
CREATE PROC [dbo].[GetDiaryByPageV2]    
 @userid int,    
 @gbid int,    
 @page int       
AS    
BEGIN      
 SET NOCOUNT ON      
  SELECT DISTINCT d.diaryid, d.CrtDate    
  INTO #T    
  FROM diary d         
  where d.gbid = @gbid       
   AND d.deletetag = 1     
   AND EXISTS(SELECT * FROM page_public pp        
        WHERE pp.diaryid = d.diaryid and d.pagetplid<>11 )    
            
CREATE TABLE #Diary(pcount int,diaryid bigint)     
 insert into #Diary    
  exec sp_GridViewByPager      
   @viewName = '#T',             --表名      
   @fieldName = ' diaryid ',      --查询字段      
   @keyName = 'diaryid',       --索引字段      
   @pageSize = 3,                 --每页记录数      
   @pageNo = @page,                     --当前页      
   @orderString = ' CrtDate desc ',          --排序条件      
   @whereString = ' 1 = 1  ' ,  --WHERE条件      
   @IsRecordTotal = 1,             --是否输出总记录条数      
   @IsRowNo = 0    
       
 SELECT d1.pcount,gbid, d.pagetplid, d.diaryid,     
    CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType,     
    d.CrtDate, pp.ckey, pp.cvalue, pp.ctype, ISNULL(d.Src,0)Src,pt.tpltype,pt.tplsubtype            
  FROM diary d         
   inner join PageTpl pt    
  on d.pagetplid = pt.pagetplid    
  INNER JOIN #Diary d1     
   on d.diaryid = d1.diaryid      
   inner join page_public pp        
   on pp.diaryid = d.diaryid        
  LEFT JOIN BasicData..[user] u        
   on u.userid = d.Author        
  where d.gbid = @gbid        
     
    
 DECLARE @TOP INT = 3    
 select d.diaryid,ca1.Contents,ca1.name,ca2.cnt from #Diary d    
 cross apply(    
 select top(@TOP)c.Contents,u.name from Comment c     
  inner join BasicData..[user] u     
  on c.userid = u.userid     
  where c.diaryid = d.diaryid order by c.CrtDate desc)ca1    
 cross apply(select SUM(1)cnt from Comment c where c.diaryid = d.diaryid)ca2    
     
 select d.diaryid,ca1.name,ca2.cnt from #Diary d    
 cross apply(    
 select top(@TOP)u.name from Nice n     
  inner join BasicData..[user] u     
  on n.userid = u.userid     
  where n.diaryid = d.diaryid order by n.CrtDate)ca1    
 cross apply(select SUM(1)cnt from Nice c where c.diaryid = d.diaryid)ca2    
      
     
END 
GO
