USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除商家活动
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_Delete]
@activityid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @tempid INT
	SELECT @tempid=companyid FROM companyactivity WHERE activityid=@activityid
	IF(@companyid=@tempid)
	BEGIN
--		DELETE [companyactivity]
--		 WHERE activityid=@activityid 	
--		DELETE [activitycomment] WHERE activityid=@activityid
		UPDATE companyactivity SET status=-1 WHERE activityid=@activityid
		UPDATE activitycomment SET status=-1 WHERE activityid=@activityid
		UPDATE company SET activitycount=activitycount-1 WHERE companyid=@companyid
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (-2)
	END

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END

GO
