USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalattach_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[portalattach_Delete]
@attachid int
AS
BEGIN	
	DELETE portalattach WHERE attachid=@attachid

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
