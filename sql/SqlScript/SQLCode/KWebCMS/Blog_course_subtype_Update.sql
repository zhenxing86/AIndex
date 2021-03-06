USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_subtype_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Blog_course_subtype_Update]
@subtypeid int,
@title nvarchar(20)
AS
BEGIN
	IF EXISTS(SELECT * FROM resourceapp..course_subtype type WHERE title=@title)
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN	
		UPDATE resourceapp..course_subtype SET title=@title WHERE subtypeid=@subtypeid
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
