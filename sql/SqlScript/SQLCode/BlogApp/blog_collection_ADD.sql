USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_collection_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加收藏记录 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-3 16:53:01
------------------------------------

CREATE PROCEDURE [dbo].[blog_collection_ADD]
@userid int,
@postid int
 AS 
	INSERT INTO blog_collection(
	[userid],[postid],[createdatetime]
	)VALUES(
	@userid,@postid,getdate()
	)
   
	IF @@ERROR <>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN 
		RETURN (1)
	END





GO
