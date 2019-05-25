USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Kindergarten_Fee_Detail_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Kindergarten_Fee_Detail_Delete]
@KID int,
@Fee_Type_ID int
AS
BEGIN
	DELETE zgyey_om..Kindergarten_Fee_Detail WHERE KID=@KID AND Fee_Type_ID=@Fee_Type_ID

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
