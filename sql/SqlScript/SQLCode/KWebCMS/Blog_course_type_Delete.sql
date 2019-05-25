USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_type_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Blog_course_type_Delete]
@id int
AS
BEGIN
	IF EXISTS(SELECT * FROM resourceapp..course_content WHERE coursetypeid=@id)
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN	
		DELETE resourceapp..course_type WHERE id=@id
	END

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
