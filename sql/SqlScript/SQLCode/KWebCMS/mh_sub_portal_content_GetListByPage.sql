USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_sub_portal_content_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_sub_portal_content_GetListByPage] 'mhxwgg',14,1,10
-- =============================================
CREATE PROCEDURE [dbo].[mh_sub_portal_content_GetListByPage]
@categorycode nvarchar(20),
@subcategoryid int,
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
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT s_contentid FROM mh_content_content_relation
		WHERE categorycode=@categorycode and status=1
		ORDER BY s_contentid DESC

		SET ROWCOUNT @size
		SELECT p.s_contentid,cat.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime,t4.subcategoryid,t4.subtitle
		FROM site s,cms_content c,mh_content_content_relation p, cms_category cat,@tmptable,
		cms_subcategory t4,mh_subcontent_relation t5
		WHERE row > @ignore AND s_contentid=tmptableid and c.deletetag = 1
		AND c.contentid=p.s_contentid AND s.siteid=cat.siteid		
		AND cat.categoryid=c.categoryid
		AND t4.subcategoryid=@subcategoryid
		AND t5.contentid=s_contentid
		ORDER BY s_contentid DESC
		
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size

		SELECT p.s_contentid,cat.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime,t4.subcategoryid,t4.subtitle
		FROM site s,cms_content c,mh_content_content_relation p ,cms_category cat,
        cms_subcategory t4,mh_subcontent_relation t5
		WHERE c.contentid=p.s_contentid AND s.siteid=cat.siteid AND p.categorycode=@categorycode
		AND cat.categoryid=c.categoryid 
		AND p.status=1 and c.deletetag = 1
		AND t4.subcategoryid=@subcategoryid
		AND t5.contentid=s_contentid
		ORDER BY s_contentid DESC		
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_sub_portal_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_sub_portal_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
