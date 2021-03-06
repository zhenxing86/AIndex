USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[activitycomment_ADD]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条活动评论记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 11:28:11
------------------------------------
CREATE PROCEDURE [dbo].[activitycomment_ADD]
@activityid int,
@author nvarchar(30),
@userid int,
@content ntext,
@parentid int


 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @activitycommentid INT

	INSERT INTO [activitycomment](
	[activityid],[author],[userid],[content],[parentid],[commentdatetime],[status]
	)VALUES(
	@activityid,@author,@userid,@content,@parentid,getdate(),1
	)
	SET @activitycommentid = @@IDENTITY

	UPDATE companyactivity SET commentcount=commentcount+1 WHERE activityid=@activityid	
	
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (@activitycommentid)
	END
GO
