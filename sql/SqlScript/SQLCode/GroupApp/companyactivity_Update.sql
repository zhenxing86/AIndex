USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyactivity_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改商家活动
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 10:47:40
------------------------------------
CREATE PROCEDURE [dbo].[companyactivity_Update]
@activityid int,
@title nvarchar(50),
@activitycontent ntext,
@targethref nvarchar(200)

 AS 
	UPDATE [companyactivity] SET 
	[title] = @title,[activitycontent] = @activitycontent,[targethref] = @targethref,[createdatetime] = getdate()
	WHERE activityid=@activityid 

	IF @@ERROR <> 0 
	BEGIN
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN(1)
	END


GO
