USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_Kindergarten_Attach_Info_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[kmp_Kindergarten_Attach_Info_Update]
@KID int,
@ContractStatus int,
@Customer_Desc int,
@Content_Desc int,
@Register_Source int,
@Real_Source int,
@Agent_Desc int,
@Reg_Domain_DateTime datetime,
@Domain_Price nvarchar(8)='',
@KinStatus int
AS
BEGIN
	IF EXISTS(SELECT * FROM zgyey_om..Kindergarten_Attach_Info WHERE KID=@KID)
	BEGIN
		UPDATE zgyey_om..Kindergarten_Attach_Info
		SET ContractStatus=@ContractStatus,Customer_Desc=@Customer_Desc,Content_Desc=@Content_Desc,
		Register_Source=@Register_Source,Real_Source=@Real_Source,Agent_Desc=@Agent_Desc,
		Reg_Domain_DateTime=@Reg_Domain_DateTime,Domain_Price=@Domain_Price,UpdateTime=GETDATE(),KinStatus=@KinStatus
		WHERE KID=@KID
	END
	ELSE
	BEGIN
		INSERT INTO zgyey_om..Kindergarten_Attach_Info
		([KID],[ContractStatus],[Customer_Desc],[Content_Desc],[Register_Source],[Real_Source],[Agent_Desc],
		[Reg_Domain_DateTime],[Domain_Price],[UpdateTime],[KinStatus])
	    VALUES
		(@KID,@ContractStatus,@Customer_Desc,@Content_Desc,@Register_Source,@Real_Source,@Agent_Desc,
		@Reg_Domain_DateTime,@Domain_Price,GETDATE(),@KinStatus) 
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
