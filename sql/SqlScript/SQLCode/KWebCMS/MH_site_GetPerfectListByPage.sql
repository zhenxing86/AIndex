USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-26
-- Description:	获取优秀幼儿园列表
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetPerfectListByPage]
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
		SELECT top 100 s.siteid FROM site s JOIN site_config t 
		ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1 where t.ispublish=1 AND s.status=1
		ORDER BY accesscount DESC

		SET ROWCOUNT @size
		SELECT s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime,kinlevel,kinimgpath
		FROM site s 
	    JOIN site_config t ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1
		left JOIN site_themesetting ON s.siteid=site_themesetting.siteid 
		left JOIN site_themelist ON site_themesetting.themeid=site_themelist.themeid 
		left JOIN @tmptable ON s.siteid=tmptableid  
		WHERE row > @ignore  ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime,kinlevel,kinimgpath
		FROM site s 
		 JOIN site_config t ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1
		 left JOIN site_themesetting ON s.siteid=site_themesetting.siteid 
		 left JOIN site_themelist ON site_themesetting.themeid=site_themelist.themeid 
		ORDER BY accesscount DESC
	END
	ELSE
	BEGIN
		SELECT s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime,kinlevel,kinimgpath
		FROM site s 
	    JOIN site_config t ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1
		left JOIN site_themesetting ON s.siteid=site_themesetting.siteid 
		left JOIN site_themelist ON site_themesetting.themeid=site_themelist.themeid 
		ORDER BY accesscount DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_GetPerfectListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
