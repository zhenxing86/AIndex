USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[zxbm_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[zxbm_Delete]
@id int
AS
BEGIN
    DELETE zxbm
    WHERE bmid=@id

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
