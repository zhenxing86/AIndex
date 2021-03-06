USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetModelByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	
-- Memo:	
*/
CREATE PROCEDURE [dbo].[kweb_content_GetModelByCategoryID]
	@categoryid int,@siteid int
AS
BEGIN		
	SELECT	TOP 1 c1.categoryid, c1.content, c1.title, c1.titlecolor, 
					c1.author, c1.createdatetime, c1.searchkey, c1.searchdescription,
					c1.browsertitle, c1.viewcount, c1.commentcount, c1.commentstatus, 
					c1.ispageing,	c2.title as categoryTitle
		FROM cms_content c1
			left join cms_category c2 on c1.categoryid = c2.categoryid
		WHERE c1.categoryid = @categoryid and c1.deletetag = 1
			AND c1.status = 1 
			and c1.siteid = @siteid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetModelByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetModelByCategoryID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
