USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsCategory]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSmsCategory]
@userId int	
AS
BEGIN
	select * from SMS..sms_category
END

GO
