USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Kindergarten_Fee_Detail_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Kindergarten_Fee_Detail_Update]
@KID int,
@Fee_Type_ID int,
@Price varchar(128)='',
@End_Date datetime,
@Comments varchar(100)=''
AS
BEGIN
	IF EXISTS(SELECT * FROM zgyey_om..Kindergarten_Fee_Detail WHERE KID=@KID AND Fee_Type_ID=@Fee_Type_ID)
	BEGIN
		UPDATE zgyey_om..Kindergarten_Fee_Detail
		SET Price=@Price,End_Date=@End_Date,Comments=@Comments
		WHERE Fee_Type_ID=@Fee_Type_ID AND KID=@KID
	END
	ELSE
	BEGIN
		INSERT INTO zgyey_om..Kindergarten_Fee_Detail([KID],[Fee_Type_ID],[Price],[End_Date],[ActionDate],[Comments])
		VALUES(@KID,@Fee_Type_ID,@Price,@End_Date,GETDATE(),@Comments) 
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
