USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除班级教学安排
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 21:13:23
------------------------------------
CREATE  PROCEDURE [dbo].[class_schedule_Delete]
@scheduleid int,
@userid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION




	
	--EXEC [class_actionlogs_Delete] @scheduleid,31

	--更新文档分类文档数量	
	--UPDATE thelp_categories SET documentcount=documentcount-1 WHERE categoryid=@categoryid

	--删除文档附件
	DELETE class_scheduleattach WHERE scheduleid=@scheduleid

	--删除文档评论e
	DELETE class_schedulecomments WHERE scheduleid=@scheduleid
	
	--删除文档记录
	 update  class_schedule set [status]=0  where scheduleid=@scheduleid 

	delete applogs..class_log where actionobjectid=@scheduleid


	IF @@ERROR <> 0 
	BEGIN 		
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		COMMIT TRANSACTION
	   RETURN (1)
	END









GO
