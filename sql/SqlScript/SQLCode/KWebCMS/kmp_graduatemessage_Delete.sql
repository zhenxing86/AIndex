USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-11
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[kmp_graduatemessage_Delete]
@id int
AS
BEGIN
	BEGIN TRANSACTION

	DELETE kmp..GraduateMessage WHERE id=@id

	DELETE kmp..GraduateMessage WHERE parentid=@id
	
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
