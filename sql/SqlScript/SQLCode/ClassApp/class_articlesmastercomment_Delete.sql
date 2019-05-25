USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlesmastercomment_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除班级文章园长点评 
--项目名称：zgyeyblog
--说明：
--时间：2009-5-18 17:43:20
------------------------------------
create PROCEDURE [dbo].[class_articlesmastercomment_Delete]
@commentid int
 AS 
--	DELETE class_articlesmastercomment WHERE commentid=@commentid
	UPDATE class_articlesmastercomment SET status=-1 WHERE commentid=@commentid

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
