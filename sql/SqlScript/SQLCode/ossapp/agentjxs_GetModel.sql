USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentjxs_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[agentjxs_GetModel]
@id int
 AS 
	SELECT 
	 1,[ID],bid,name,num,[deletetag] FROM [agentjxs]
	 WHERE ID=@id


GO
