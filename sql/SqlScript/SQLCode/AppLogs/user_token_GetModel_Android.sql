USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[user_token_GetModel_Android]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[user_token_GetModel_Android]
@token VARCHAR(100)
AS
BEGIN
  SELECT top 1 token,info from mobile_user_tokens where token=@token order by createdatetime desc
END



GO
