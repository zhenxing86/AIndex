USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_TitleUrl_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[kmp_T_TitleUrl_Delete]
@id int
AS
BEGIN
    DELETE zgyey_om..T_TitleUrl
    WHERE id=@id

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END



GO
