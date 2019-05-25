USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_collection_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：收藏夹日记总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-04 10:11:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_collection_GetCount]
@userid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blog_collection WHERE userid=@userid
	RETURN @TempID		





GO
