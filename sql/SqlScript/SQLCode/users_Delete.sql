USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Delete
------------------------------------
CREATE PROCEDURE [dbo].[users_Delete]
@id int
 AS 
	DELETE [users]
	 WHERE ID=@id 



GO
