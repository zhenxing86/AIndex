USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-28
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[Blog_course_content_Add]
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
	DECLARE @orderno int
	DECLARE @subno int

	SELECT @orderno=MAX(orderno) FROM resourceapp..course_content
	IF @orderno IS NULL
		SET @orderno=1
	ELSE
		SET @orderno=@orderno+1

	INSERT INTO resourceapp..course_content (coursetypeid,subtypeno,title,gradeid,filepath,filename,thumbpath,thumbfilename,createdatetime,orderno,viewcount,[level],status)
	VALUES(@coursetypeid,@subtypeno,@title,@gradeid,@filepath,@filename,@thumbpath,@thumbfilename,GETDATE(),@orderno,0,@level,@status)

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
