USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_videocomments_GetCount]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取视频评论总数
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE PROCEDURE [dbo].[class_videocomments_GetCount]
@videoid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_videocomments WHERE videoid=@videoid and status=1
	RETURN @TempID	






GO
