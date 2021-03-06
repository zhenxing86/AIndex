USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetListByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	分页获取相册
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetListByCategoryID]  
@categoryid int,  
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
   --定义临时表  
   row int IDENTITY (1, 1),  
   tmptableid bigint  
  )  
    
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid)   
  SELECT albumid FROM cms_album   
  WHERE categoryid = @categoryid AND photocount>0 and deletetag = 1 
  ORDER BY orderno DESC  
  
  SET ROWCOUNT @size  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,  
  'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid),c.net  
  FROM cms_album c join @tmptable on c.albumid=tmptableid   
  WHERE row > @ignore and deletetag = 1 ORDER BY orderno DESC  
 END  
 ELSE IF(@page=1)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,  
  'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=cms_album.categoryid) ,net  
  FROM cms_album   
  WHERE categoryid = @categoryid AND photocount>0 and deletetag = 1
  ORDER BY orderno DESC  
 END  
 ELSE IF(@page=0)  
 BEGIN  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,  
  'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=cms_album.categoryid) ,net  
  FROM cms_album   
  WHERE categoryid = @categoryid AND photocount>0 and deletetag = 1 
  ORDER BY orderno DESC  
 END  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
