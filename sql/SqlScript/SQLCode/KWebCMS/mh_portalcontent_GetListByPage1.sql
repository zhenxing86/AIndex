USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portalcontent_GetListByPage1]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-12
-- Description:	
-- Memo:		
*/
CREATE PROCEDURE [dbo].[mh_portalcontent_GetListByPage1]
	@categorycode nvarchar(20),
	@page int,
	@size int
AS
BEGIN 
	SET NOCOUNT ON   
	IF(@page>1)  
	BEGIN     
		DECLARE @beginRow INT
		DECLARE @endRow INT
		DECLARE @pcount INT
		SET @beginRow = (@page - 1) * @size    + 1
		SET @endRow = @page * @size		

		SELECT s_contentid, siteid, name, sitedns, title, author, createdatetime
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.contentid desc) AS rows, 
								p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  
					FROM	site s, 
								cms_content c, 
								mh_content_content_relation p   
					WHERE c.contentid = p.s_contentid 
						AND s.siteid = c.siteid 
						AND p.categorycode = @categorycode  
						AND p.status = 1 and c.deletetag = 1
			) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow 
	END  
	ELSE IF(@page=1)  
	BEGIN  
		SET ROWCOUNT @size  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  
			FROM	site s,
						cms_content c,
						mh_content_content_relation p   
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode  
				AND p.status = 1 and c.deletetag = 1
			ORDER BY c.contentid desc  
	END  
	ELSE IF(@page=0)  
	BEGIN  
		SELECT	p.s_contentid, c.siteid, s.name, s.sitedns, c.title, c.author, c.createdatetime  
			FROM	site s,
						cms_content c,
						mh_content_content_relation p  
			WHERE c.contentid = p.s_contentid 
				AND s.siteid = c.siteid 
				AND p.categorycode = @categorycode  
				AND p.status = 1 and c.deletetag = 1
			ORDER BY c.contentid DESC  
	END   
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalcontent_GetListByPage1', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalcontent_GetListByPage1', @level2type=N'PARAMETER',@level2name=N'@page'
GO
