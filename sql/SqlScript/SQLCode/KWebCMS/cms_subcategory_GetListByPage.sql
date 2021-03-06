USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_subcategory_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		along
-- Create date: 2009-02-25
-- Description:	分页获取子分类
-- =============================================
CREATE PROCEDURE [dbo].[cms_subcategory_GetListByPage]
@categoryid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT subcategoryid FROM cms_subcategory WHERE categoryid=@categoryid order by subcategoryid DESC

		SET ROWCOUNT @size
		SELECT t.* FROM cms_subcategory t join @tmptable on t.subcategoryid=tmptableid WHERE row > @ignore ORDER BY subcategoryid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT * FROM cms_subcategory WHERE categoryid=@categoryid ORDER BY subcategoryid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM cms_subcategory WHERE categoryid=@categoryid ORDER BY subcategoryid DESC
	END	
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_subcategory_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_subcategory_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
