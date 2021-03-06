USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[ActivationCode_Exist]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-14
-- Description:	函数用于判断激活码是否有效
-- Memo:		
*/
CREATE PROC [dbo].[ActivationCode_Exist]
	@IP VARCHAR(50),
	@activecode VARCHAR(10)
AS
BEGIN
	DECLARE @TryCnt int = 0
	SELECT @TryCnt = TryCnt 
		FROM IPretry 
		WHERE IP = @IP 
		AND CrtDate = CONVERT(VARCHAR(10),GETDATE(),120)
		
	IF @TryCnt >= 5
	RETURN 6
	ELSE IF EXISTS(SELECT * FROM ActivationCode WHERE CodeNo = @activecode AND userid IS NULL)
	BEGIN
		UPDATE IPretry 
				SET TryCnt = 0
				WHERE IP = @IP 
					AND CrtDate = CONVERT(VARCHAR(10),GETDATE(),120)
		RETURN 0	
	END 
	else if EXISTS(SELECT * FROM ActivationCode WHERE CodeNo = @activecode AND userid IS NOT NULL)
		RETURN -1
	ELSE IF NOT EXISTS(SELECT * FROM ActivationCode WHERE CodeNo = @activecode) 
	BEGIN
		IF EXISTS(SELECT * FROM IPretry WHERE IP = @IP AND CrtDate = CONVERT(VARCHAR(10),GETDATE(),120))
		UPDATE IPretry 
			SET TryCnt = TryCnt + 1 
			WHERE IP = @IP 
				AND CrtDate = CONVERT(VARCHAR(10),GETDATE(),120)
		ELSE 
		INSERT INTO IPretry(IP,CrtDate,TryCnt)
			SELECT @IP, GETDATE(), 1
		SET @TryCnt = @TryCnt + 1
		RETURN @TryCnt
	END

END

GO
