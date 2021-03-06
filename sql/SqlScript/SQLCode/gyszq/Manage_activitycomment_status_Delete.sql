USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_activitycomment_status_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商品评价删除
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-15 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_activitycomment_status_Delete]
@activitycommentid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	UPDATE t1 SET commentcount=commentcount-1 FROM companyactivity t1 INNER JOIN activitycomment t2 ON t1.activityid=t2.activityid WHERE t2.activitycommentid=@activitycommentid
	UPDATE activitycomment SET status=-1 WHERE activitycommentid=@activitycommentid

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
