USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[role_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[role_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[agbid]    ,[name]    ,[duty]    ,[describe]    ,[deletetag]  	 FROM [role]
	 WHERE ID=@id 



GO
