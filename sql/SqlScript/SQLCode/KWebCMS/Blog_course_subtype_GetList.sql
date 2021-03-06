USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_subtype_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-06
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[Blog_course_subtype_GetList]
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
		SELECT subtypeid FROM resourceapp..course_subtype
		ORDER BY subtypeid DESC
		
		SET ROWCOUNT @size
		SELECT DISTINCT subtypeid,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.subtypeno=s.subtypeid) 
		FROM resourceapp..course_subtype s,resourceapp..course_content c,@temptable 
		WHERE s.subtypeid=tempid AND row>@ignore
		ORDER BY subtypeid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT DISTINCT subtypeid,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.subtypeno=s.subtypeid) 
		FROM resourceapp..course_subtype s,resourceapp..course_content c 
		ORDER BY subtypeid DESC
		--WHERE s.subtypeid=c.subtypeno
	END
	ELSE
	BEGIN
		SELECT DISTINCT subtypeid,s.title,
		'count'=(SELECT count(id) FROM resourceapp..course_content c WHERE c.subtypeno=s.subtypeid) 
		FROM resourceapp..course_subtype s,resourceapp..course_content c 
		ORDER BY subtypeid DESC
		--WHERE s.subtypeid=c.subtypeno
	END
END









GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Blog_course_subtype_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
