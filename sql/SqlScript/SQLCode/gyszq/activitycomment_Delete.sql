USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[activitycomment_Delete]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除活动评论 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 11:28:11
------------------------------------
CREATE PROCEDURE [dbo].[activitycomment_Delete]
@activitycommentid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @temp INT
	DECLARE @activityid INT
	SELECT @temp=t2.companyid,@activityid=t2.activityid FROM activitycomment t1 INNER JOIN companyactivity t2 ON t1.activityid=t2.activityid WHERE t1.activitycommentid=@activitycommentid
	IF(@companyid=@temp)
	BEGIN
--		DELETE [activitycomment]
--		WHERE activitycommentid=@activitycommentid 
		UPDATE activitycomment SET status=-1 WHERE activitycommentid=@activitycommentid
		
		UPDATE companyactivity SET commentcount=commentcount-1 WHERE activityid=@activityid
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
