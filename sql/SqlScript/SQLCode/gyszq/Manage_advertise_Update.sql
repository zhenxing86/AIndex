USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：广告修改
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_Update]
@advertiseid int,
@titile nvarchar(50),
@links nvarchar(300),
@begintime datetime,
@endtime datetime

 AS 
	BEGIN TRANSACTION

	UPDATE [advertise] SET titile=@titile,links=@links,begintime=@begintime,endtime=@endtime WHERE advertiseid=@advertiseid

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
