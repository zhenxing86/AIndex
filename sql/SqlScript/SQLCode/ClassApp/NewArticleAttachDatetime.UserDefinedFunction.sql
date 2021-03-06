USE [ClassApp]
GO
/****** Object:  UserDefinedFunction [dbo].[NewArticleAttachDatetime]    Script Date: 06/15/2013 15:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NewArticleAttachDatetime]
	(
	@articleid int
	)
RETURNS NVARCHAR(100)
AS	
	BEGIN
		DECLARE @datetimestr nvarchar(50)
		IF(EXISTS(SELECT * FROM class_articleattachs WHERE  articleid=@articleid))
		BEGIN
			DECLARE @newattachdatetime datetime
			SELECT 
				@newattachdatetime=max(createdatetime)
			 FROM class_articleattachs where  articleid=@articleid
			SET @datetimestr=convert(nvarchar(100),@newattachdatetime,120) 
		END
		ELSE
		BEGIN
			SET @datetimestr=''
		END
		RETURN @datetimestr
	END
GO
