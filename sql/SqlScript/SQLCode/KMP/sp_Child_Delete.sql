USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Child_Delete]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Child_Delete]
@ID int
 AS 
	BEGIN TRAN
	UPDATE T_Users
	 SET ACTIVITY = -1 WHERE [ID] = @ID

	UPDATE T_Child
	 SET Status = -1 WHERE [UserID] = @ID
	COMMIT TRAN
GO
