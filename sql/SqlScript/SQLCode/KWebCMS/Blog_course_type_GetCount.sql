USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_type_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Blog_course_type_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM resourceapp..course_type 
	RETURN @count
END





GO
