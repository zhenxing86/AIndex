USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Delete
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_Delete]
@id int
 AS 
	DELETE [beforefollow]
	 WHERE ID=@id 



GO
