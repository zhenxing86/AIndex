USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_mastercomment_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：删除园长点评 
--项目名称：zgyeyblog
--说明：
--时间：2009-2-3 10:20:28
------------------------------------
CREATE PROCEDURE [dbo].[class_mastercomment_Delete]
@mastercommentid INT
 AS 
	DELETE class_schedulemastercomment WHERE mastercommentid=@mastercommentid

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END







GO
