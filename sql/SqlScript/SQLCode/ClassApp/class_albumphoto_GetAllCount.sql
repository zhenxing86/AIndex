USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_albumphoto_GetAllCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_albumphoto_GetAllCount]
	@classid int
AS
BEGIN 
	SET NOCOUNT ON
	DECLARE @TempID int
	SELECT @TempID = sum(isnull(photocount,0)) 
		FROM class_album 
		WHERE classid = @classid
		and [status]=1
	RETURN Isnull(@TempID, 0)
END

GO
