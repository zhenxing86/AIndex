USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_UpdateTitle]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-06
-- Description:	修改附件标题
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_UpdateTitle]
@contentattachsid int,
@title nvarchar(100)
AS
BEGIN
	UPDATE cms_contentattachs SET title=@title WHERE contentattachsid=@contentattachsid

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
