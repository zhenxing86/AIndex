USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advice_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除建议 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-24 9:20:09
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advice_Delete]
@adviceid int
 AS 
	UPDATE [advice] SET status=-1 WHERE adviceid=@adviceid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
