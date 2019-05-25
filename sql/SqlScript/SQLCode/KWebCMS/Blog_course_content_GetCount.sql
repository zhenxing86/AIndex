USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-28
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[Blog_course_content_GetCount]
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM resourceapp..course_content JOIN resourceapp..course_subtype
	ON subtypeno=subtypeid
	RETURN @count
END








GO
