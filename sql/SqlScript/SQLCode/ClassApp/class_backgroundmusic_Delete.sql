USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_backgroundmusic_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：删除班级背景音乐
--项目名称：ClassHomePage
--说明：
--时间：2009-1-15 16:21:36
------------------------------------
CREATE PROCEDURE [dbo].[class_backgroundmusic_Delete]
@id int,
@userid int
 AS 

	DECLARE @classid int
	declare @kid int
	SELECT @classid=classid,@kid=kid FROM class_backgroundmusic WHERE id=@id 
	

--	DELETE class_backgroundmusic
--	 WHERE id=@id 
		UPDATE class_backgroundmusic SET status=-1 WHERE id=@id


	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END







GO
