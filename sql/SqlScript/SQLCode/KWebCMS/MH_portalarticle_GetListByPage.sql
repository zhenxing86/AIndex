USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalarticle_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	获取门户新闻列表
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalarticle_GetListByPage]
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
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM portalarticle 
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT p.contentid,p.siteid,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,[name],sitedns,regdatetime
		FROM cms_content c,portalarticle p,site s,@tmptable 
		WHERE row > @ignore AND c.[contentid]=tmptableid AND c.contentid=p.contentid AND c.siteid=s.siteid and c.deletetag = 1
		ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT top(6) p.contentid,p.siteid,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,[name],sitedns,regdatetime
		FROM cms_content c,portalarticle p,site s 
		WHERE c.contentid=p.contentid AND c.siteid=s.siteid and c.deletetag = 1
		ORDER BY p.contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.contentid,p.siteid,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,[name],sitedns,regdatetime
		FROM cms_content c,portalarticle p,site s 
		WHERE c.contentid=p.contentid AND c.siteid=s.siteid and c.deletetag = 1
		ORDER BY p.contentid DESC	
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalarticle_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
