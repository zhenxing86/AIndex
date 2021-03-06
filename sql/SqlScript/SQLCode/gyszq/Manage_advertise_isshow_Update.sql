USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_isshow_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改广告是否显示 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_isshow_Update]
@advertiseid int
 AS 
	DECLARE @isshow INT
	SELECT @isshow=isshow FROM advertise WHERE advertiseid=@advertiseid
	IF(@isshow=0)
	BEGIN
		UPDATE advertise SET isshow=1 WHERE advertiseid=@advertiseid
	END
	ELSE
	BEGIN
		UPDATE advertise SET isshow=0 WHERE advertiseid=@advertiseid
	END

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
