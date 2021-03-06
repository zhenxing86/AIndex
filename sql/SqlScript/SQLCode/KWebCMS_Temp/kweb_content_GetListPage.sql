USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListPage]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
  
  
-- =============================================  
-- exec KWebCMS_Temp..[kweb_content_GetListPage] 'gg',11061,1,10  
-- =============================================  
CREATE PROCEDURE [dbo].[kweb_content_GetListPage]  
@categorycode nvarchar(10),  
@siteid int,  
@page int,  
@size int  
AS  
BEGIN   
  
   SET ROWCOUNT @size  
   SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime],t1.appcontent FROM cms_content t1  
   INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid      
   WHERE   
   t2.categorycode=@categorycode  
   AND t1.[status]=1    
   AND t1.siteid=@siteid           
   ORDER BY t1.[contentid] DESC  
    
    
END  
  
  
  
  
  
  
  
  
GO
