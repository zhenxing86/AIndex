USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_Dictionary_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_T_Dictionary_GetList]
@code nvarchar(20)
AS
BEGIN
    SELECT [id],[caption],[code],[catalog]
    FROM zgyey_OM..T_Dictionary
	WHERE [catalog] IN (SELECT id FROM zgyey_om..T_Dictionary WHERE code=@code AND [catalog]=0)
END





GO
