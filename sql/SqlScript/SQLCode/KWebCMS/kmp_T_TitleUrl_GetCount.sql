USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_TitleUrl_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[kmp_T_TitleUrl_GetCount]
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM zgyey_om..T_TitleUrl
	WHERE [type]=3
    RETURN @count
END



GO
