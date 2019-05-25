USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_templet_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl	
-- Create date: 2014-05-15
-- Description:	删除控件模版表
-- =============================================
CREATE PROCEDURE [dbo].[cms_templet_Delete]
	@id int
AS
BEGIN
	update enlistonline_templet set deletetag=0 where ID=@id
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
