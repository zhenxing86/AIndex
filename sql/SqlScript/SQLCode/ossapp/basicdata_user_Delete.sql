USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Delete
------------------------------------
CREATE PROCEDURE [dbo].[basicdata_user_Delete]
@userid int
 AS 
	DELETE [basicdata_user]
	 WHERE userid=@userid 




GO
