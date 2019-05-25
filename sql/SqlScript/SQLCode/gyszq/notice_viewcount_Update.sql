USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[notice_viewcount_Update]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：更新通知查看数
--项目名称：ServicePlatform
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[notice_viewcount_Update]
@noticeid int
 AS 
	UPDATE notice SET viewcount=viewcount+1 WHERE  noticeid=@noticeid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
