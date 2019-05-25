USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetCountByKid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取幼儿园成员日志数
--项目名称：BLOG
--说明：
--时间：2009-7-2 14:22:32
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetCountByKid]
@kid int
AS
BEGIN
	DECLARE @count INT
	SELECT @count=count(1) FROM blog_posts 
    where siteid=@kid
	RETURN @count
END





GO
