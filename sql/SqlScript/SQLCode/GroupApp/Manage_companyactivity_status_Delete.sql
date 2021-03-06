USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_companyactivity_status_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：活动删除
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-15 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_companyactivity_status_Delete]
@activityid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	UPDATE activitycomment SET status=-1 WHERE activityid=@activityid
	UPDATE t1 SET activitycount=activitycount-1 FROM company t1 INNER JOIN companyactivity t2 ON t1.companyid=t2.companyid WHERE t2.activityid=@activityid
	UPDATE companyactivity SET status=-1 WHERE activityid=@activityid


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
