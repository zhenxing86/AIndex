USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetCountByAllSite]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kweb_album_GetCountByAllSite]
@categorycode nvarchar(10),
@siteid varchar(50)
AS
BEGIN

DECLARE @newsiteid int  
SELECT top 1 @newsiteid=string FROM [dbo].[SpitString] (@siteid ,',')  
DECLARE @count int  
SELECT @count=count(*) 
  FROM cms_album   
  WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE  (siteid=0 or siteid=@newsiteid) and  categorycode=@categorycode) AND photocount>0  
    AND siteid in (SELECT string FROM [dbo].[SpitString] (@siteid ,',')) and deletetag = 1 
    
RETURN @count   
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetCountByAllSite', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetCountByAllSite', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
