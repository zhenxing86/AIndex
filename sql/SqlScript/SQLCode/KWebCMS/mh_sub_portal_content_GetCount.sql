USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_sub_portal_content_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	获取子分类列表数量
--exec [mh_sub_portal_content_GetCount] 'mhxwgg',5
-- =============================================
CREATE PROCEDURE [dbo].[mh_sub_portal_content_GetCount]
@categorycode nvarchar(20),
@subcategoryid int
AS
BEGIN
	DECLARE @count int

	SELECT @count=count(1)		
		FROM site s,cms_content c,mh_content_content_relation p ,cms_category cat,
        cms_subcategory t4,mh_subcontent_relation t5
		WHERE c.contentid=p.s_contentid AND s.siteid=cat.siteid AND p.categorycode=@categorycode
		AND cat.categoryid=c.categoryid 
		AND p.status=1 and c.deletetag = 1
		AND t4.subcategoryid=@subcategoryid
		AND t5.contentid=s_contentid
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_sub_portal_content_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
