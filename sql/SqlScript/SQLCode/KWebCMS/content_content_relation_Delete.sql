USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[content_content_relation_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-12
-- Description:	删除分类
-- =============================================
CREATE PROCEDURE [dbo].[content_content_relation_Delete]
@contentid int
AS
BEGIN
	BEGIN TRANSACTION

	DELETE mh_content_content_relation WHERE s_contentid=@contentid

	DELETE mh_subcontent_relation WHERE contentid=@contentid

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END


GO
