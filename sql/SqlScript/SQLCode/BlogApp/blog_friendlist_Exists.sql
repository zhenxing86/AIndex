USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_Exists]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：判断是否是好友 
--项目名称：ZGYEYBLOG
--说明：

--时间：2008-12-26 11:48:07
------------------------------------
CREATE PROCEDURE [dbo].[blog_friendlist_Exists]
@userid int,
@frienduserid int
AS
--    if(exists (select * from dbo.blog_friendlist  where userid=@userid and frienduserid =@frienduserid))
--	BEGIN
--        RETURN 1
--	END
--	ELSE
--	BEGIN
--		IF(@userid=@frienduserid)
--		BEGIN
--			RETURN 1
--		END
--		ELSE
--		BEGIN
--			RETURN 0
--		END
--	END 
RETURN 1








GO
