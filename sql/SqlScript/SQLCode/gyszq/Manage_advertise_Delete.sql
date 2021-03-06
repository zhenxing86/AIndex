USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除广告 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_Delete]
@advertiseid int
 AS 
	BEGIN TRANSACTION

	DECLARE @orderno INT
	DECLARE @position INT 
	SELECT @orderno=orderno,@position=position FROM advertise WHERE advertiseid=@advertiseid
	UPDATE advertise SET status=-1 WHERE advertiseid=@advertiseid
	UPDATE advertise SET orderno=orderno-1 WHERE position=@position and orderno>@orderno


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
