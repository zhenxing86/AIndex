USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_kindergarten_ADD]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[user_kindergarten_ADD]
@userid int,
@kid int

 AS 
	UPDATE [user] SET kid = @kid where userid = @userid
	IF(@@ERROR<>0)
	begin
		return (-1)
	end
	else
	begin
		return 1
	end

GO
