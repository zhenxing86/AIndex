USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMSTemp_GetListByPage]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SMSTemp_GetListByPage]
@tmptype int,
@page int,
@size int
 AS 

IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int identity(1,1) primary key,
			tempid int
		)

		INSERT INTO @temptable
		SELECT 
		id from SMS_Temp where smstype=@tmptype
		ORDER BY lastUpdateTime DESC
		
		SET ROWCOUNT @size
		SELECT 
	id,3,smstype,smscontent,1,lastUpdateTime
	 FROM SMS_Temp s,@temptable 
		WHERE s.id=tempid AND row>@ignore 
		ORDER BY lastUpdateTime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		id,3,smstype,smscontent,1,lastUpdateTime from SMS_Temp where smstype=@tmptype
		ORDER BY lastUpdateTime DESC
	END
	ELSE
	BEGIN
		SELECT 
		id,3,smstype,smscontent,1,lastUpdateTime from SMS_Temp where smstype=@tmptype
		ORDER BY lastUpdateTime DESC
	END

GO
