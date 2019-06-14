USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_kmp_KinMasterMessage_Revert]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：还原园长信箱内容
--项目名称：ServicePlatformManage
--说明：
--时间：2010-04-10 09:09:49
------------------------------------
CREATE PROCEDURE [dbo].[Manage_kmp_KinMasterMessage_Revert]
@id int
AS
BEGIN
	UPDATE kmp..KinMasterMessage SET status=0 WHERE id=@id

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
