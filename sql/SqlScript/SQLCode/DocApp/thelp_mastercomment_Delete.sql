USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_mastercomment_Delete]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除园长点评 
--项目名称：zgyeyblog
--说明：
--时间：2010-10-22 10:20:28
------------------------------------
CREATE PROCEDURE [dbo].[thelp_mastercomment_Delete]
@mastercommentid int

 AS 
	DELETE thelp_mastercomment WHERE mastercommentid=@mastercommentid

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END







GO
