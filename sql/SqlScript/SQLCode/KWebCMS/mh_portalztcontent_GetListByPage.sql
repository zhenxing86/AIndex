USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portalztcontent_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_portalcontent_GetListByPage] 'mhjhap', 1, 10
-- =============================================
CREATE PROCEDURE [dbo].[mh_portalztcontent_GetListByPage]  
@page int,  
@size int  
AS  
BEGIN  
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
  INSERT INTO @tmptable(tmptableid)   
  SELECT s_contentid FROM mh_content_content_relation  
  WHERE status=2   
  ORDER BY s_contentid DESC  
  
  SET ROWCOUNT @size  
  SELECT c.contentid s_contentid,c.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime  
  FROM site s,cms_content c,@tmptable   
  WHERE row > @ignore AND c.contentid=tmptableid and c.deletetag = 1
  AND Exists(Select * From mh_content_content_relation p Where c.contentid=p.s_contentid) AND s.siteid=c.siteid    
   
  ORDER BY c.createdatetime DESC  
 END  
 ELSE IF(@page=1)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT c.contentid s_contentid,c.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime  
  FROM site s,cms_content c
  WHERE Exists(Select * From mh_content_content_relation p Where c.contentid=p.s_contentid AND p.status=2) 
    AND s.siteid=c.siteid and c.deletetag = 1
   
   and s.siteid>0  
  ORDER BY c.createdatetime DESC  
 END  
 ELSE IF(@page=0)  
 BEGIN  
  SELECT c.contentid s_contentid,cat.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime  
  FROM site s,cms_content c,cms_category cat  
  WHERE Exists(Select * From mh_content_content_relation p Where c.contentid=p.s_contentid AND p.status=2) AND s.siteid=cat.siteid  
  AND cat.categoryid=c.categoryid  
  and s.siteid>0 and c.deletetag = 1
  ORDER BY c.contentid DESC  
 END   
END 

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'门户网站中园所动态内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalztcontent_GetListByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalztcontent_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
