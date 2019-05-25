USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[defaultpage_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	删除默认首页
-- =============================================
CREATE PROCEDURE [dbo].[defaultpage_Delete]
@defaultpageid int
AS
BEGIN
	DELETE defaultpage WHERE defaultpageid=@defaultpageid

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
