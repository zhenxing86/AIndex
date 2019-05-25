USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_kmp_KinMasterMessage_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除园长信箱内容 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-04-09 15:09:49
------------------------------------
CREATE PROCEDURE [dbo].[Manage_kmp_KinMasterMessage_Delete]
@id int
AS
BEGIN
	UPDATE kmp..KinMasterMessage SET status=-1 WHERE id=@id

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END
GO
