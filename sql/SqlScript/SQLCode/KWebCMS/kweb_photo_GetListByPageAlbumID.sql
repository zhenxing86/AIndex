USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetListByPageAlbumID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	分页获取图片集
-- =============================================
CREATE PROCEDURE [dbo].[kweb_photo_GetListByPageAlbumID]
@albumid int,
@page int,
@size int
AS
BEGIN	

if(@albumid=34758 or @albumid=34759)
begin
	exec KWebCMS_Temp..[kweb_photo_GetListByPageAlbumID] @albumid,@page,@size
end

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
		INSERT INTO @tmptable(tmptableid) SELECT photoid FROM cms_photo WHERE albumid=@albumid and deletetag = 1 ORDER BY photoid DESC

		SET ROWCOUNT @size
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,net
		FROM cms_photo c inner join @tmptable on c.photoid=tmptableid WHERE row > @ignore and c.deletetag = 1 ORDER BY photoid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,net 
		FROM cms_photo WHERE albumid=@albumid and deletetag = 1 ORDER BY photoid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,net
		FROM cms_photo WHERE albumid=@albumid and deletetag = 1 ORDER BY photoid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByPageAlbumID', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByPageAlbumID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
