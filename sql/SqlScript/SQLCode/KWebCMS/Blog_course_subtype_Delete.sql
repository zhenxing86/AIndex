USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_subtype_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Blog_course_subtype_Delete]
@subtypeid int
AS
BEGIN
	IF EXISTS(SELECT * FROM resourceapp..course_content WHERE subtypeno=@subtypeid)
	BEGIN
		RETURN -1
	END

	DELETE resourceapp..course_subtype WHERE subtypeid=@subtypeid

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
