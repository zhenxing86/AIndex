USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentcomment_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-07
-- Description:	分页获取评论
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentcomment_GetListByPage]
@contentid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT contentcommentid FROM cms_contentcomment WHERE contentid=@contentid and parentid=0 ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT c.* FROM cms_contentcomment c join @tmptable on c.contentcommentid=tmptableid WHERE row > @ignore ORDER BY createdatetime DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM cms_contentcomment WHERE contentid=@contentid and parentid=0 ORDER BY createdatetime DESC
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentcomment_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
