USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_notice_orderno_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改通知置顶 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[Manage_notice_orderno_Update]
@noticeid int
 AS 
	DECLARE @orderno int
	SELECT @orderno=orderno FROM notice WHERE noticeid=@noticeid
	IF(@orderno=0)
	BEGIN
		UPDATE [notice] SET orderno=1 WHERE noticeid=@noticeid 
	END
	ELSE
	BEGIN
		UPDATE [notice] SET orderno=0 WHERE noticeid=@noticeid
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
