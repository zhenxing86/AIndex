USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_type_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Blog_course_type_GetListByPage]
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int identity(1,1) primary key,
			tempid int
		)

		INSERT INTO @temptable
		SELECT id FROM resourceapp..course_type
		ORDER BY id DESC
		
		SET ROWCOUNT @size
		SELECT DISTINCT s.id,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.coursetypeid=s.id)
		FROM resourceapp..course_type s,resourceapp..course_content c,@temptable 
		WHERE s.id=tempid AND row>@ignore
		ORDER BY id DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT DISTINCT s.id,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.coursetypeid=s.id)
		FROM resourceapp..course_type s,resourceapp..course_content c
		ORDER BY id DESC
	END
	ELSE
	BEGIN
		SELECT DISTINCT s.id,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.coursetypeid=s.id)
		FROM resourceapp..course_type s,resourceapp..course_content c
		ORDER BY id DESC
	END
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Blog_course_type_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
