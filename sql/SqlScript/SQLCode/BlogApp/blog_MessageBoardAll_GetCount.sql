USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_MessageBoardAll_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取留言数
--项目名称：zgyeyblog
--说明：
--时间：2008-10-13 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_MessageBoardAll_GetCount]
@userid int
 AS 
	DECLARE @TempID int
	DECLARE @TempID1 int
	SELECT @TempID=count(1) FROM blog_messageboard WHERE userid=@userid AND parentid=0 
--	SELECT @TempID1=count(1) FROM blog_messageboard t1 WHERE t1.fromuserid=@userid and
-- (select count(1) from blog_messageboard where parentid=t1.messageboardid)>0
	RETURN @TempID	



GO
