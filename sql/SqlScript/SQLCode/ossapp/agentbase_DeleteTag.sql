USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentbase_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[agentbase_DeleteTag]
@id int
 AS 
	update  [agentbase] set deletetag=0
	 WHERE ID=@id 



GO
