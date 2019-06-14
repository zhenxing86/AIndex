USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_backgroundmusic_GetModel]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取班级背景音乐 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-15 16:21:36
------------------------------------
CREATE PROCEDURE [dbo].[class_backgroundmusic_GetModel] 
@classid int
 AS 
	SELECT 
	id,kid,classid,backgroundmusicpath,backgroundmusictitle,isdefault,datatype,uploaddatetime,net
	 FROM class_backgroundmusic WHERE classid=@classid and status=1 order by isdefault desc







GO
