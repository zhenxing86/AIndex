USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_GetCountByStatus]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-20
-- Description:	GetCountByStatus
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_GetCountByStatus]
@status int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM resourceapp..course_content WHERE status=@status
	RETURN @count
END






GO
