USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articleattachs_GetList]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取班级文章附件列表 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articleattachs_GetList]
@articleid int
 AS 

	SELECT 
	attachid,articleid,title,filename,filepath,createdatetime
	 FROM class_articleattachs where articleid=@articleid and status=1




GO
