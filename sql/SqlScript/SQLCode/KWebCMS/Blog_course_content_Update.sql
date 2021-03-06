USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-28
-- Description:	Update
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_Update]
@id int,
@coursetypeid int,
@subtypeno int,
@title nvarchar(20),
@gradeid int,
@filepath nvarchar(200),
@filename nvarchar(30),
@thumbpath nvarchar(200),
@thumbfilename nvarchar(30),
@level int,
@status int
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE resourceapp..course_content
	SET coursetypeid=@coursetypeid,subtypeno=@subtypeno,title=@title,
	gradeid=@gradeid,filepath=@filepath,filename=@filename,
	thumbpath=@thumbpath,thumbfilename=@thumbfilename,level=@level,status=@status
	WHERE id=@id

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
