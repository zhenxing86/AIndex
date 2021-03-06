USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetClassVideoListCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：分页取视频信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE PROCEDURE [dbo].[class_GetClassVideoListCount]
@classid int,
@userid int 
 AS
		DECLARE @kid int
		DECLARE @usertype int
		DECLARE @count int
		DECLARE @count1 int
		DECLARE @count2 int
		DECLARE @count3 int
		select @usertype=usertype from BasicData.dbo.[user] where userid=@userid
		IF(@usertype=0)
		BEGIN
			SELECT @classid=cid FROM BasicData.dbo.user_class WHERE userid=@userid
		END
		SELECT @count1=count(1) from basicdata..personalize_class where cid=@classid
		
		SELECT @count3=count(1) FROM class_video WHERE classid=@classid and status=1
		SET @count=@count1+@count3
		RETURN @count




GO
