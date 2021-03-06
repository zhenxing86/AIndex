USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  hanbin    
-- Create date: 2009-03-03    
-- Description: 取文章内容    
--[kweb_content_GetModel] 382290    
-- =============================================    
CREATE PROCEDURE [dbo].[kweb_content_GetModel]    
@contentid int    
AS    
BEGIN    
 SELECT t1.categoryid,t1.[content],t1.title,t1.titlecolor,t1.author,t1.createdatetime,t1.searchkey,    
 t1.searchdescription,t1.browsertitle,t1.viewcount,t1.commentcount,t1.commentstatus,t1.ispageing,    
 t2.title ,t1.content --isnull(t1.appcontent,t1.content)  --暂时还是取content内容，原因：后台修改appcontent的功能尚未上线      
 FROM cms_content t1 left join cms_category t2 on t1.categoryid=t2.categoryid    
WHERE contentid=@contentid and t1.deletetag = 1    
    
    update cms_content set viewcount=viewcount+1 where contentid=@contentid    
END 
GO
