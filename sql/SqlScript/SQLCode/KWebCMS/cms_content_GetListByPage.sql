USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-03
-- Description:	分页读取文章数据
--[cms_content_GetListByPage] 17095,1,10,12511
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetListByPage] 
@categoryid int,
@page int,
@size int,
@siteid int
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
  INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content     
  WHERE categoryid=@categoryid and siteid=@siteid and deletetag = 1 
 ORDER BY isnull(istop,0) DESC, orderno DESC,createdatetime DESC  ,titlecolor DESC  
    
  SET ROWCOUNT @size    
  SELECT c.* FROM cms_content c join @tmptable on c.[contentid]=tmptableid     
  WHERE row > @ignore and deletetag = 1
  ORDER BY isnull(istop,0) DESC, orderno DESC,createdatetime DESC, titlecolor DESC    
 END    
 ELSE    
 BEGIN    
  SET ROWCOUNT @size   
   if(@siteid<>18)  
   begin  
  SELECT * FROM cms_content     
  WHERE categoryid=@categoryid  and siteid=@siteid and deletetag = 1  
 ORDER BY isnull(istop,0) DESC, orderno DESC,createdatetime DESC, titlecolor DESC   
 end  
 else  
 BEGIN  
 SELECT * FROM cms_content     
  WHERE categoryid=@categoryid  and siteid=@siteid and deletetag = 1
 ORDER BY isnull(istop,0) DESC, orderno DESC,titlecolor DESC,createdatetime DESC  
 END    
 END    
END    


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
