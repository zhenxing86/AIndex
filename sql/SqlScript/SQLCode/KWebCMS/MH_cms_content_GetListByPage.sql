USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_cms_content_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetList 最新动态和网站建设指南
--exec [MH_cms_content_GetListByPage] 'mhxwgg',18,1,10
-- =============================================
CREATE PROCEDURE [dbo].[MH_cms_content_GetListByPage]
@categorycode nvarchar(10),
@siteid int,
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
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT contentid FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) AND status=1 and deletetag = 1
		ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT contentid,categoryid,[content],title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,viewcount,orderno,commentstatus,ispageing 
		FROM cms_content JOIN @tmptable ON contentid=tmptableid
		WHERE row > @ignore and deletetag = 1 ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT contentid,categoryid,[content],title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,viewcount,orderno,commentstatus,ispageing 
		FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) AND status=1 and deletetag = 1
		ORDER BY createdatetime DESC
	END
	ELSE
	BEGIN
		SELECT contentid,categoryid,[content],title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,viewcount,orderno,commentstatus,ispageing 
		FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) AND status=1 and deletetag = 1
		ORDER BY createdatetime DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_cms_content_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
