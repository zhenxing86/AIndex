USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetFriendDiaryByPage]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date: 2013-12-3    
-- Description: 分页读取好友成长日记的列表    
-- Memo:use ngbapp    
exec GetFriendDiaryByPage 295765, 1  
*/    
--    
CREATE PROC [dbo].[GetFriendDiaryByPage]  
 @userid int,  
 @page int     
AS  
BEGIN    
 SET NOCOUNT ON    
          
CREATE TABLE #Diary(diaryid bigint, name varchar(50), utype varchar(10), userid int, headpic nvarchar(200),headpicupdate datetime )   
  
 insert into #Diary  
exec sp_MutiGridViewByPager  
  @fromstring = 'diary d     
  INNER JOIN growthbook gb  
   on d.gbid = gb.gbid   
  inner join Basicdata.[dbo].GetFriendList(@D1) gf  
   on gb.userid = gf.userid   
  where d.deletetag = 1   
   AND d.pagetplid not in(11,12,13)  
   AND EXISTS(SELECT * FROM page_public pp      
        WHERE pp.diaryid = d.diaryid )',      --数据集  
  @selectstring =   
  'd.diaryid, gf.name, gf.utype, gf.userid, gf.headpic, gf.headpicupdate',      --查询字段  
  @returnstring =   
  'diaryid,  name, utype, userid, headpic, headpicupdate ',      --返回字段  
  @pageSize = 10,                 --每页记录数  
  @pageNo = @page,                     --当前页  
  @orderString = ' d.diaryid desc',          --排序条件  
  @IsRecordTotal = 0,             --是否输出总记录条数  
  @IsRowNo = 0,           --是否输出行号  
  @D1 = @userid   
   
     
 SELECT gbid, d.pagetplid, d.diaryid,   
    CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType,   
    d.CrtDate, pp.ckey, pp.cvalue, pp.ctype, ISNULL(d.Src,0)Src, d1.name,   
    d1.utype, d1.userid, d1.headpic, d1.headpicupdate,pt.tpltype,pt.tplsubtype      
  FROM diary d     
   inner join PageTpl pt  
  on d.pagetplid = pt.pagetplid   
  INNER JOIN #Diary d1   
   on d.diaryid = d1.diaryid    
   inner join page_public pp      
   on pp.diaryid = d.diaryid      
  LEFT JOIN BasicData..[user] u      
   on u.userid = d.Author  
  WHERE D.Share=1     
     
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
  where n.diaryid = d.diaryid order by n.CrtDate desc)ca1  
 cross apply(select SUM(1)cnt from Nice c where c.diaryid = d.diaryid)ca2  
    
END  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页读取好友成长日记的列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendDiaryByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendDiaryByPage', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetFriendDiaryByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
