USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	分页获取图片
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_GetListByPage]
@albumid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT photoid FROM cms_photo WHERE albumid=@albumid and deletetag = 1 ORDER BY orderno DESC,photoid DESC

		SET ROWCOUNT @size
		SELECT c.* FROM cms_photo c join @tmptable on c.photoid=tmptableid WHERE row > @ignore and deletetag = 1 ORDER BY orderno DESC,photoid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM cms_photo WHERE albumid=@albumid and deletetag = 1 ORDER BY orderno DESC,photoid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
