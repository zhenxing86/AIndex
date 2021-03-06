USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedule_GetModel]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到班级教学安排的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:03:20
------------------------------------
CREATE PROCEDURE [dbo].[class_schedule_GetModel]
@scheduleid int,
@userid int

 AS 
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	--UPDATE class_schedule SET viewcount=viewcount+1 WHERE scheduleid=@scheduleid

	SELECT 
		scheduleid AS scheduleid,title,userid,author,classid,kid, content,1,1,1,convert(varchar(19),createdatetime,120)as createdatetime,viewcount
	 FROM class_schedule
	 WHERE scheduleid=@scheduleid 



	
--	DECLARE @readcount INT
	--SELECT @readcount=count(1) FROM class_readlogs 
	--WHERE userid=@userid AND objectid=@scheduleid AND objecttype=2
--	IF(@readcount=0 and @userid<>0)
--	BEGIN
--		EXEC class_readlogs_ADD @userid,@scheduleid,2
--	END

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
