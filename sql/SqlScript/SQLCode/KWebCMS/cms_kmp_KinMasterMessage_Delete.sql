USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_kmp_KinMasterMessage_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-21
-- Description:	删除园长信箱内容
-- =============================================
CREATE PROCEDURE [dbo].[cms_kmp_KinMasterMessage_Delete]
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
