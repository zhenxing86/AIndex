USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_type_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[Blog_course_type_Add]
@title nvarchar(20)
AS
BEGIN
	IF EXISTS(SELECT * FROM resourceapp..course_type WHERE title=@title)
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN	
		INSERT INTO resourceapp..course_type VALUES(@title)
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
