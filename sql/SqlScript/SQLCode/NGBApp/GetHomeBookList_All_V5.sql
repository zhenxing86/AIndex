USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBookList_All_V5]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie        
-- Create date: 2014-07-09        
-- Description: 根据kid获取ngbapp..homebook所有的家园联系册        
-- Memo:        
[GetHomeBookList_All_V5] 4246   
[GetHomeBookList_All_V5] 12511      
*/        
--        
CREATE PROC [dbo].[GetHomeBookList_All_V5]        
 @kid int            
AS        
BEGIN                  
 SET NOCOUNT ON   
   
 declare @book table (hbid int,term nvarchar(10),termtype int,cid int,cname nvarchar(40), isgraduate int ,study_year int,ver int,corder int)  
 insert into @book       
  select h.hbid, h.term,cast(Right(h.term,1) as int) termtype, h.cid,ca.cname, ca.isgraduate,cast (Left(h.term,4) as int),2,ca.[order]   
   from  HomeBook h        
    inner join BasicData..class_all ca     
     on h.cid = ca.cid and h.term = ca.term 
     and ca.deletetag=1   
   where h.kid = @kid      
    
  insert into @book       
   select h.hbid, h.term,cast(Right(h.term,1) as int) termtype, h.classid,h.class_name, ca.isgraduate,cast (Left(h.term,4) as int),1,ca.[order]   
 from  gbapp..HomeBook h        
  inner join BasicData..class_all ca     
   on h.classid = ca.cid and h.term = ca.term 
    and ca.deletetag=1  
 where h.kid = @kid and h.term<>'2014-0'  
    
  insert into @book   
   select h.homebookid hbid, h.term,cast(Right(h.term,1) as int) termtype, h.classid,h.classname, ca.isgraduate,cast (Left(h.term,4) as int),0,ca.[order]   
    FROM ebook..HB_HomeBook h  
     inner join BasicData..class_all ca    
      on h.classid=ca.cid and ca.deletetag=1   
    where kid=@kid   
  
   
 select hbid,term,termtype,cid,cname,isgraduate,  
  case when termtype=0 then study_year-1 else study_year end study_year,ver,corder,  
  ROW_NUMBER()over(partition by term,cid order by termtype)rowno  
   into #result  
 from @book   
   
 delete from #result where rowno >1 --删除重复记录  
  
   --select * from #result 
             select isnull(a.cid,b.cid) cid,isnull(a.cname,b.cname) cname,isnull(a.study_year,b.study_year) study_year,  
    a.hbid,a.term,a.termtype,a.ver,b.hbid,b.term,b.termtype,b.ver,b.isgraduate  
 from (Select * From #result Where termtype = 1) a   
     full outer join (Select * From #result Where termtype = 0) b   
     ON a.cid = b.cid and a.study_year = b.study_year 
      
  -- select isnull(a.cid,b.cid) cid,isnull(a.cname,b.cname) cname,isnull(a.study_year,b.study_year) study_year,  
  --  case when a.termtype=1 then a.hbid else '' end ahbid,
  --  case when a.termtype=1 then a.term else '' end aterm,
  --  case when a.termtype=1 then a.termtype else '' end atermtype,
  --  case when a.termtype=1 then a.ver else '' end aver,
  --  case when b.termtype=0 then b.hbid else '' end bhbid,
  --  case when b.termtype=0 then b.term else '' end bterm,
  --  case when b.termtype=0 then b.termtype else '' end btermtype,
  --  case when b.termtype=0 then b.ver else '' end bver,b.isgraduate 
  --  from #result a   
  --   full outer join #result b   
  --   ON a.cid = b.cid and a.study_year = b.study_year --and b.termtype = 0   
  --  Where (
		--(a.termtype <>0 and b.termtype<>1) --or (a.termtype=b.termtype and a.study_year = b.study_year)
  --  )  
    
    
    drop table #result    
END   
  

GO
