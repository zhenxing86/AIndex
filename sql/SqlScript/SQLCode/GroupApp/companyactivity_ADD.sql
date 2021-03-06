USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加商家活动
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_ADD]
@companyid int,
@title nvarchar(50),
@activitycontent ntext,
@targethref nvarchar(200)


 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @activityid INT

	INSERT INTO [companyactivity](
	[companyid],[title],[activitycontent],[targethref],[createdatetime],[commentcount],[status]
	)VALUES(
	@companyid,@title,@activitycontent,@targethref,getdate(),0,1
	)
	SET @activityid = @@IDENTITY
	
	UPDATE company SET activitycount=activitycount+1 WHERE companyid=@companyid
	
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN(@activityid)
	END

GO
