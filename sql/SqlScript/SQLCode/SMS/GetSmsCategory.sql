USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetSmsCategory]    Script Date: 05/14/2013 14:52:41 ******/
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
