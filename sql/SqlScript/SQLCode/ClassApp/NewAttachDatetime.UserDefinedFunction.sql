USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[NewAttachDatetime]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NewAttachDatetime]
	(
	@docid int
	)
RETURNS NVARCHAR(100)
AS	
	BEGIN
		DECLARE @datetimestr nvarchar(50)
		IF(EXISTS(SELECT * FROM class_scheduleattach WHERE  scheduleid=@docid))
		BEGIN
			DECLARE @newattachdatetime datetime
			SELECT 
				@newattachdatetime=max(createdatetime)
			 FROM class_scheduleattach where scheduleid=@docid
			SET @datetimestr=convert(nvarchar(100),@newattachdatetime,120) 
		END
		ELSE
		BEGIN
			SET @datetimestr=''
		END
		RETURN @datetimestr
	END
GO
