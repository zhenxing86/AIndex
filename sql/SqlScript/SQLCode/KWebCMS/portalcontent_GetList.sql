USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalcontent_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[portalcontent_GetList]
@categorycode nvarchar(20),
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
		SELECT portalcontentid FROM portalcontent 
		WHERE categorycode=@categorycode
		ORDER BY portalcontentid DESC

		SET ROWCOUNT @size
		SELECT p.contentid,p.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime
		FROM site s,cms_content c,portalcontent p,@tmptable 
		WHERE row > @ignore AND portalcontentid=tmptableid AND c.contentid=p.contentid
      AND s.siteid=p.siteid and c.deletetag = 1
		ORDER BY portalcontentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.contentid,p.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime
		FROM site s,cms_content c,portalcontent p 
		WHERE c.contentid=p.contentid AND s.siteid=p.siteid AND categorycode=@categorycode
      and c.deletetag = 1
		ORDER BY portalcontentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.contentid,p.siteid,s.name,s.sitedns,c.title,c.author,c.createdatetime
		FROM site s,cms_content c,portalcontent p 
		WHERE c.contentid=p.contentid AND s.siteid=p.siteid AND categorycode=@categorycode
      and c.deletetag = 1
		ORDER BY portalcontentid DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
