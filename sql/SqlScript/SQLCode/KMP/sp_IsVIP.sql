USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_IsVIP]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_IsVIP]
@UserID int
AS
	SELECT VIPstatus FROM T_Child WHERE UserID = @UserID
GO
