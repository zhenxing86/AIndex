USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-28
-- Description:	Delete
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_Delete]
@id int
AS
BEGIN	
	DELETE resourceapp..course_content WHERE id=@id
	
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
