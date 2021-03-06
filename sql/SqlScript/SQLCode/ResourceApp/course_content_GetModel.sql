USE [ResourceApp]
GO
/****** Object:  StoredProcedure [dbo].[course_content_GetModel]    Script Date: 2014/11/24 23:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取互动学堂课件详细信息
--项目名称：CLASSHOMEPAGE
--说明：
--时间：2009-3-29 22:30:07
------------------------------------
CREATE PROCEDURE [dbo].[course_content_GetModel]
@id int,
@userid int
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

		SELECT id,filepath,[filename],thumbpath,thumbfilename,status,createdatetime FROM course_content WHERE id=@id 
		
		UPDATE course_content SET viewcount=viewcount+1 WHERE id=@id
		
		DECLARE @readcount INT
		SELECT @readcount=count(1) FROM AppLogs.dbo.class_readlogs 
		WHERE userid=@userid AND objectid=@id AND objecttype=3
		IF(@readcount=0 and @userid<>0)
		BEGIN
			INSERT INTO AppLogs.dbo.class_readlogs(
			[userid],[readdatetime],[objectid],[objecttype]
			)VALUES(
			@userid,getdate(),@id,3
			)
			--EXEC class_readlogs_ADD @userid,@id,3
		END

		--EXEC class_actionlogs_ADD @userid,'','查看课件' ,'27',@id,@userid,0,0
	
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	END





GO
