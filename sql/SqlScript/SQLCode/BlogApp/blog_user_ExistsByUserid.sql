USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_ExistsByUserid]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：用户是否存在
--项目名称：zgyeyblog
--说明：
--时间：2009-06-25 16:16:29
------------------------------------
CREATE PROCEDURE [dbo].[blog_user_ExistsByUserid]
@userid int
AS
	DECLARE @TempID int	

	IF EXISTS(SELECT 1 FROM BasicData.dbo.user_bloguser t1 inner join BasicData.dbo.[user] t2 on t1.userid=t2.userid WHERE t1.bloguserid=@userid and t2.deletetag=1)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (0)
	END 

return (1)





GO
