USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentpackage_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[agentpackage_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[gid]    ,[money]    ,[remark]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag]  	 FROM [agentpackage]
	 WHERE ID=@id 



GO
