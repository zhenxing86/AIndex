USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_MarketTrace_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[kmp_MarketTrace_Update]
@Kid int,
@Market ntext='',
@ContentMemo ntext='',
@actionuser nvarchar(50)
AS
BEGIN
	IF EXISTS(SELECT * FROM zgyey_om..MarketTrace WHERE Kid=@Kid)
	BEGIN
		UPDATE zgyey_om..MarketTrace
		SET Market=@Market,ContentMemo=@ContentMemo,actionuser=@actionuser
		WHERE Kid=@Kid
	END
	ELSE
	BEGIN
		INSERT INTO zgyey_om..MarketTrace([Kid],[Market],[ContentMemo],[UpdateTime],[actionuser])
		VALUES(@Kid,@Market,@ContentMemo,GETDATE(),@actionuser) 
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
