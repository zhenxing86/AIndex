USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_GetCountByLevel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-20
-- Description:	GetCountByLevel
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_GetCountByLevel]
@level int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM resourceapp..course_content WHERE level=@level
	RETURN @count
END







GO
