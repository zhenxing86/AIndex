USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_GetModel]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到相册的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 10:58:57
------------------------------------
CREATE PROCEDURE [dbo].[class_album_GetModel]
@albumid int
 AS 
	SELECT 
	albumid,title,description,photocount,classid,kid,userid,author,createdatetime,coverphotodatetime,coverphoto,net
	 FROM class_album
	 WHERE albumid=@albumid AND status=1




GO
