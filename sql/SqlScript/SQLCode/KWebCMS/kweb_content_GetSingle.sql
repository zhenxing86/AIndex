USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetSingle]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 




-- =============================================    
-- Author:  liaoxin    
-- Create date: 2009-03-04    
-- Description: 分页读取没有草稿的数据    
-- kweb_content_GetSingle 'JXKB',21620,1,10  
-- =============================================    
CREATE PROCEDURE [dbo].[kweb_content_GetSingle]      
@categorycode nvarchar(10),      
@siteid int,      
@page int,      
@size int      
AS      
BEGIN       
if(exists(select 1 from theme_kids where kid=@siteid)       
 or not exists(select 1 from cms_content where siteid=@siteid)       
 or exists(select 1 from tryend_kid where kid=@siteid))      
begin      
 --SET @siteid=11061      
 exec [KWebCMS_Temp]..[kweb_content_GetSingle] @categorycode,11061,1,1      
end      
      
 IF(@page>1)      
 BEGIN      
  DECLARE @prep int,@ignore int      
  SET @prep = @size * @page      
  SET @ignore=@prep - @size      
      
  DECLARE @tmptable TABLE      
  (      
   row int IDENTITY (1, 1),      
   tmptableid bigint      
  )      
        
  SET ROWCOUNT @prep      
  INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1      
  INNER JOIN cms_category t2 ON  t1.categoryid=t2.categoryid       
  WHERE      
  t2.categorycode=@categorycode      
  AND t1.[status]=1 and t1.deletetag = 1    
  AND t1.siteid=@siteid      
       
         ORDER BY Case When @categorycode = 'ZSZL' Then t1.createdatetime Else T1.orderno End Desc, t1.contentid DESC        
       
      
  SET ROWCOUNT @size      
  SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime]       
  FROM cms_content c join @tmptable on c.[contentid]=tmptableid WHERE row > @ignore and c.deletetag = 1      
  ORDER BY Case When @categorycode = 'ZSZL' Then c.createdatetime Else GETDATE() End Desc, orderno DESC,contentid DESC      
 END      
 ELSE IF(@page=1)      
 BEGIN      
  SET ROWCOUNT @size      
  SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1      
  INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid       
  WHERE       
  --(t2.siteid=@siteid or t2.siteid=0)      
     --AND      
   t2.categorycode=@categorycode      
  AND t1.[status]=1 and t1.deletetag = 1     
  AND t1.siteid=@siteid      
        ORDER BY Case When @categorycode = 'ZSZL' Then t1.createdatetime Else T1.orderno End Desc, t1.contentid DESC      
       
 END      
 ELSE IF(@page=0)       
 BEGIN      
   SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1      
  INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid       
  WHERE       
  --(t2.siteid=@siteid or t2.siteid=0)      
     --AND       
  t2.categorycode=@categorycode      
  AND t1.[status]=1 and t1.deletetag = 1    
  AND t1.siteid=@siteid      
        ORDER BY Case When @categorycode = 'ZSZL' Then t1.createdatetime Else GETDATE() End Desc, t1.orderno DESC,t1.contentid DESC      
          
 END      
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetSingle', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetSingle', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetSingle', @level2type=N'PARAMETER',@level2name=N'@page'
GO
