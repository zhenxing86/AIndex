USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentarea_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[agentarea_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[gid]    ,[province]    ,[city]    ,[deletetag]  	 FROM [agentarea]
	 WHERE ID=@id 



GO
