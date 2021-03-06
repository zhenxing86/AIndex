USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsBirthday]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsBirthday]
	(
	@birthday varchar(50)
	)
RETURNS INT
AS
	BEGIN
		DECLARE @isbirthday int
		DECLARE @birthdaymonth int
		DECLARE @nowmonth int
		
		DECLARE @birthdaytmp datetime
		IF(@birthday='' OR @birthday IS NULL)
		BEGIN--
				RETURN 0
		END
		ELSE IF(isdate(@birthday)=1)
		BEGIN
			SET @birthdaytmp=convert(datetime,@birthday)
		END
		ELSE 
		BEGIN
			RETURN 0
		END
		
		SELECT 	@birthdaymonth=datepart(month,@birthdaytmp)
		SELECT @nowmonth=datepart(month,getdate())
		IF(@birthdaymonth<>@nowmonth)
		BEGIN	
			SELECT @isbirthday =0	 
		END
		ELSE
		BEGIN
		    SELECT @isbirthday=1
		END		
		
		RETURN @isbirthday	 
	END
GO
