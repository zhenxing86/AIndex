USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetSingle]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- 
-- exec [KWebCMS_Temp]..[kweb_content_GetSingle] 'zszl',11061,1,1
-- =============================================
CREATE PROCEDURE [dbo].[kweb_content_GetSingle]
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN	

	
	
		SET ROWCOUNT @size
		SELECT t1.[contentid],t1.[categoryid],t1.[content],t1.[title],t1.[titlecolor],t1.[author],t1.[createdatetime] FROM cms_content t1
		INNER JOIN cms_category t2 ON t1.categoryid=t2.categoryid 
		WHERE 
		 t2.categorycode=@categorycode
		AND t1.[status]=1
		AND t1.siteid=@siteid        
	
	
END






        








GO
