USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_Dictionary_GetParentList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[kmp_T_Dictionary_GetParentList]
@code nvarchar(20)
AS
BEGIN
    SELECT [id],[caption],[code],[catalog]
    FROM kmp..T_Dictionary
	WHERE code=@code
END


GO
