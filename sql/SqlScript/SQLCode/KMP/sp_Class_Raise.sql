USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Raise]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Class_Raise]
@KindergartenID int
 AS 
	BEGIN TRAN

	UPDATE T_Class
	 SET Type = Type +1 where KindergartenID = @KindergartenID
	
	COMMIT TRAN
GO
