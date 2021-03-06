USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_notice_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加通知 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[Manage_notice_ADD]
@title nvarchar(50),
@author nvarchar(20),
@titlecolor nvarchar(10),
@content ntext,
@status int

 AS 
	DECLARE @noticeid INT
	INSERT INTO [notice](
	[title],[author],[titlecolor],[content],[createdatetime],[viewcount],[orderno],[status]
	)VALUES(
	@title,@author,@titlecolor,@content,getdate(),0,0,@status
	)
	SET @noticeid = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (@noticeid)
END


GO
