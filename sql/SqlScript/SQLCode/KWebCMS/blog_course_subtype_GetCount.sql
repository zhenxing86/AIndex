USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_course_subtype_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-05-25
-- Description:	GetCount
-- =============================================
create PROCEDURE [dbo].[blog_course_subtype_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM resourceapp..course_subtype 
	RETURN @count
END






GO
