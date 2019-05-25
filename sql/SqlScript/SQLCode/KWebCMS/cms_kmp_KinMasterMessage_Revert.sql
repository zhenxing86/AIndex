USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_kmp_KinMasterMessage_Revert]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-21
-- Description:	还原园长信箱内容
-- =============================================
CREATE PROCEDURE [dbo].[cms_kmp_KinMasterMessage_Revert]
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
