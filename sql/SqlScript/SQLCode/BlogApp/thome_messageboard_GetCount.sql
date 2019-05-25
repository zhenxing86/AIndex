USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_messageboard_GetCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：家长老师留言总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-13 11:54:19
------------------------------------
CREATE PROCEDURE [dbo].[thome_messageboard_GetCount]
@userid int,
@categoryid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM thome_messageboard  
	WHERE categoryid=@categoryid and userid=@userid
	RETURN @TempID	







GO
