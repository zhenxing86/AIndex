USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[init_cms_content]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
select * from area  
-- Author:        
-- Create date:   
-- Description:   
-- Memo:     
*/    
CREATE PROCEDURE [dbo].[init_cms_content]
as  
BEGIN  
 SET NOCOUNT ON  
   
 SELECT ID, Level, ID Superior   
 INTO #CET  
  FROM area   
  WHERE ID IN(724,721,729,722)  
   UNION ALL  
 SELECT ID, Level, Superior   
  FROM area   
  WHERE Superior IN(724,721,729,722)  
  
 SELECT 724 AS ID  
 INTO #CET1  
  UNION ALL  
 SELECT 721  
  UNION ALL  
 SELECT 729  
  UNION ALL  
 SELECT 722  
   
delete dbo.cms_content  where status <> 2
  
  
insert into cms_content(contentid, categoryid, content, title, titlecolor, author, createdatetime, searchkey, searchdescription, 
                        browsertitle, viewcount, commentcount, orderno, commentstatus, ispageing, status, siteid)
 SELECT p.*   
  FROM #CET1 c1   
   CROSS APPLY   
   (  
    select top(50) c.contentid, c.categoryid, c.content, c.title, c.titlecolor, c.author, c.createdatetime, c.searchkey, c.searchdescription, 
                   c.browsertitle, c.viewcount, c.commentcount, c.orderno, c.commentstatus, c.ispageing, c.status, c.siteid 
     from dbo.gartenlist g   
      inner join KWebCMS..cms_content c  
       on c.siteid = g.kid   
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid<>722 and c.deletetag = 1
     order by createdatetime desc  
   )p 
   
   
--历下区722全部获取，不仅仅获取前50条 
insert into cms_content(contentid, categoryid, content, title, titlecolor, author, createdatetime, searchkey, searchdescription, 
                        browsertitle, viewcount, commentcount, orderno, commentstatus, ispageing, status, siteid)
SELECT p.*   
  FROM #CET1 c1   
   CROSS APPLY   
   (  
    select c.contentid, c.categoryid, c.content, c.title, c.titlecolor, c.author, c.createdatetime, c.searchkey, c.searchdescription, 
           c.browsertitle, c.viewcount, c.commentcount, c.orderno, c.commentstatus, c.ispageing, c.status, c.siteid 
     from dbo.gartenlist g   
      inner join KWebCMS..cms_content c  
       on c.siteid = g.kid   
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid=722 and c.deletetag = 1

   )p


delete a from 
	ActicleState a   
      inner join KWebCMS..cms_content c  
       on c.contentid = a.contentid and c.deletetag = 1
      inner join  dbo.gartenlist g
        on c.siteid = g.kid    
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c.categoryid=17095 and g.areaid=722 
     
insert into ActicleState(contentid, ishow, uid, uptime)  
SELECT p.contentid,1,0,GETDATE() 
  FROM #CET1 c1   
   CROSS APPLY   
   (  
    select  c.*
     from dbo.gartenlist g   
      inner join KWebCMS..cms_content c  
       on c.siteid = g.kid and c.deletetag= 1
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid=722 

   )p  
  
END  


GO
