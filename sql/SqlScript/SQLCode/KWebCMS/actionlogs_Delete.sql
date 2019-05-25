USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-09
-- Description:	删除操作日志
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Delete]
@id int
AS
BEGIN
	DELETE actionlogs WHERE id=@id
	
	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END



GO
