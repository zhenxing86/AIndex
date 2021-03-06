USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_portalztttcontent_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-23
-- Description:	GetList
--exec [mh_portalcontent_GetListByPage] 'mhjhap', 1, 10
-- =============================================
CREATE PROCEDURE [dbo].[mh_portalztttcontent_GetListByPage]
@status int,
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
		WHERE status=@status
		ORDER BY s_contentid DESC

		SET ROWCOUNT @size
		SELECT p.s_contentid,c.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime,c.content,p.categorycode
		FROM site s,cms_content c,mh_content_content_relation p,@tmptable 
		WHERE row > @ignore AND s_contentid=tmptableid and c.deletetag = 1
		AND c.contentid=p.s_contentid AND s.siteid=c.siteid		
		--AND cat.categoryid=c.categoryid
		ORDER BY p.actiondate DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.s_contentid,c.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime,c.content,p.categorycode
		FROM site s,cms_content c,mh_content_content_relation p 
		WHERE c.contentid=p.s_contentid AND s.siteid=c.siteid and c.deletetag = 1
		--AND cat.categoryid=c.categoryid 
		AND p.status=@status
		ORDER BY p.actiondate DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.s_contentid,cat.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime,c.content,p.categorycode
		FROM site s,cms_content c,mh_content_content_relation p ,cms_category cat
		WHERE c.contentid=p.s_contentid AND s.siteid=cat.siteid and c.deletetag = 1
		AND cat.categoryid=c.categoryid
		AND p.status=@status
		ORDER BY p.actiondate DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_portalztttcontent_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
