USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_Dictionary_GetListByParentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_T_Dictionary_GetListByParentID]
@parentid int
AS
BEGIN
    SELECT [id],[caption],[code],[catalog]
    FROM zgyey_om..T_Dictionary
	WHERE [catalog]=@parentid
END





GO
