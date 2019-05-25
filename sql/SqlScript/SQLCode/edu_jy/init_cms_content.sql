/*  
select * from area  
-- Author:        
-- Create date:   
-- Description:   
-- Memo:     
*/    
ALTER PROCEDURE init_cms_content
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
  
  
insert into cms_content  
 SELECT p.*   
  FROM #CET1 c1   
   CROSS APPLY   
   (  
    select top(50) c.*
     from dbo.gartenlist g   
      inner join KWebCMS..cms_content c  
       on c.siteid = g.kid   
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid<>722 
     order by createdatetime desc  
   )p 
   
   
--历下区722全部获取，不仅仅获取前50条 
insert into cms_content  
SELECT p.*   
  FROM #CET1 c1   
   CROSS APPLY   
   (  
    select  c.*
     from dbo.gartenlist g   
      inner join KWebCMS..cms_content c  
       on c.siteid = g.kid   
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid=722 

   )p


delete a from 
	ActicleState a   
      inner join KWebCMS..cms_content c  
       on c.contentid = a.contentid 
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
       on c.siteid = g.kid   
      inner join #CET ct   
       on ct.ID = g.areaid  
     where c1.id = ct.Superior and c.categoryid=17095 and g.areaid=722 

   )p  
  
END  

GO
init_cms_content