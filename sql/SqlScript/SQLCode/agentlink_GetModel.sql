USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentlink_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[agentlink_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[gid]    ,[name]    ,[tel]    ,[qq]    ,[email]    ,[post]    ,[remark]    ,[deletetag]  	 FROM [agentlink]
	 WHERE ID=@id 



GO
