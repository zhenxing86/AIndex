USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_GetUseridByKmpuserid]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：取博客用户id
--项目名称：zgyeyblog
--说明：
--时间：2011-07-25 16:16:29
------------------------------------
CREATE PROCEDURE [dbo].[blog_user_GetUseridByKmpuserid]
@userid int
AS
	DECLARE @TempID int	
	SELECT @TempID=t1.bloguserid FROM BasicData.dbo.user_bloguser t1 inner join BasicData.dbo.[user] t2 on t1.userid=t2.userid WHERE t1.userid=@userid and t2.deletetag=1
	RETURN Isnull(@TempID, 0)


GO
