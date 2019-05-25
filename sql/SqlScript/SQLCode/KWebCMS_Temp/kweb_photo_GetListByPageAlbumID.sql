USE [KWebCMS_Temp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetListByPageAlbumID]    Script Date: 2014/11/24 23:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================

-- =============================================
create PROCEDURE [dbo].[kweb_photo_GetListByPageAlbumID]
@albumid int,
@page int,
@size int
AS
BEGIN	
	
		SET ROWCOUNT @size
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,indexshow,flashshow,createdatetime,net 
		FROM cms_photo WHERE albumid=@albumid 
	
END








GO
