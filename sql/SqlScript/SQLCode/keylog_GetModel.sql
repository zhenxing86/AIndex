USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[keylog_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[keylog_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[uid]    ,[dotime]    ,[descname]    ,[ipaddress]    ,[module]    ,[remark]    ,[deletetag]  	 FROM [keylog]
	 WHERE ID=@id 



GO
