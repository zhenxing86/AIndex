USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Kindergarten_Favorable_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Kindergarten_Favorable_Update]
@KID int,
@Favorable_Type_ID int,
@Comments varchar(128)=''
AS
BEGIN
	IF EXISTS(SELECT * FROM zgyey_om..Kindergarten_Favorable WHERE KID=@KID AND Favorable_Type_ID=@Favorable_Type_ID)
	BEGIN
		UPDATE zgyey_om..Kindergarten_Favorable
		SET Comments=@Comments
		WHERE Favorable_Type_ID=@Favorable_Type_ID AND KID=@KID
	END
	ELSE
	BEGIN
		INSERT INTO zgyey_om..Kindergarten_Favorable([KID],[Favorable_Type_ID],[ActionDate],[Comments])
		VALUES(@KID,@Favorable_Type_ID,GETDATE(),@Comments) 
	END

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
