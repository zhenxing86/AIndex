USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboard_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：首页取留言数
--项目名称：zgyeyblog
--说明：
--时间：2009-02-03 17:18:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboard_GetCount]
@userid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blog_messageboard WHERE userid=@userid AND parentid=0 
	RETURN @TempID		





GO
