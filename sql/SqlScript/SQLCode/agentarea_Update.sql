USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentarea_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[agentarea_Update]
 @ID int,
 @gid int,
 @province int,
 @city int,
 @deletetag int
 
 AS 
	UPDATE [agentarea] SET 
  [gid] = @gid,
 [province] = @province,
 [city] = @city,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
