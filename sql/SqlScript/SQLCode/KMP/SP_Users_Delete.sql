USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Users_Delete]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Users_Delete]
@ID int
 AS 
	DELETE T_Users
	 WHERE [ID] = @ID
GO
