USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_notice_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改通知 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[Manage_notice_Update]
@noticeid int,
@title nvarchar(50),
@author nvarchar(20),
@titlecolor nvarchar(10),
@content ntext,
@status int
 AS 
	UPDATE [notice] SET 
	[title] = @title,[author] = @author,[titlecolor] = @titlecolor,[content] = @content,[createdatetime] = getdate(),[status] = @status
	WHERE noticeid=@noticeid 

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
