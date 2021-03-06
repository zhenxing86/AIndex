USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetListPageByAllSite]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- alter date: 2009-03-06
-- Description:	分页获取相册
--exec [kweb_album_GetListPageByAllSite] 'YEZP','58,143,4556,221',1,10
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetListPageByAllSite]  
@categorycode nvarchar(10),  
@siteid varchar(50),  
@page int,  
@size int  
AS  
BEGIN   
    DECLARE @newsiteid int  
    SELECT top 1 @newsiteid=string FROM [dbo].[SpitString] (@siteid ,',')  
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
  WHERE categoryid in (SELECT categoryid FROM cms_category WHERE (siteid=@newsiteid or siteid=0) and categorycode=@categorycode) AND photocount>0  
  and siteid in (SELECT string FROM [dbo].[SpitString] (@siteid ,',')) and deletetag = 1
        ORDER BY orderno DESC  
  
  SET ROWCOUNT @size  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,s.[name],s.siteDNS,c.siteid,c.net  
  FROM cms_album c join @tmptable on c.albumid=tmptableid  join  site s ON c.siteid=s.siteid  
  WHERE row > @ignore and c.deletetag = 1
  ORDER BY orderno DESC  
 END  
 ELSE IF(@page=1)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime ,s.[name],s.siteDNS,c.siteid,c.net 
    FROM cms_album c ,site s  
    WHERE c.siteid=s.siteid and c.deletetag = 1
      and c.categoryid IN (SELECT categoryid FROM cms_category WHERE (siteid=@newsiteid or siteid=0) and  categorycode=@categorycode) AND photocount>0  
      and c.siteid in (SELECT string FROM [dbo].[SpitString] (@siteid ,','))  
        ORDER BY albumid DESC  
 END  
 ELSE IF(@page=0)  
 BEGIN  
  SELECT albumid,categoryid,title,searchkey,searchdescription,photocount,cover,orderno,createdatetime,net  
  FROM cms_album   
  WHERE categoryid IN  (SELECT categoryid FROM cms_category WHERE  (siteid=@siteid or siteid=0) and categorycode=@categorycode) AND photocount>0   
     and siteid=@siteid and deletetag = 1 
       ORDER BY albumid DESC  
 END  
  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPageByAllSite', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPageByAllSite', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPageByAllSite', @level2type=N'PARAMETER',@level2name=N'@page'
GO
