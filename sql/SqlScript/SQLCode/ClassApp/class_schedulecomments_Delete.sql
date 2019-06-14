USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedulecomments_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除教学安排评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:57:00
------------------------------------
CREATE PROCEDURE [dbo].[class_schedulecomments_Delete]
@schedulecommentid int

 AS 
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION


	
	DELETE [class_schedulecomments]
	 WHERE schedulecommentid=@schedulecommentid 

	--EXEC [class_actionlogs_Delete] @schedulecommentid,25
	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --COMMIT TRANSACTION	  
		RETURN (1)
	END







GO
