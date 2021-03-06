USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_subtype_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-06
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[Blog_course_subtype_Add]
@title nvarchar(30)
AS
BEGIN
	IF EXISTS (SELECT title FROM resourceapp..course_subtype WHERE title=@title)
	BEGIN
		RETURN -1
	END

	INSERT INTO resourceapp..course_subtype VALUES(@title)

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END








GO
