USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_belong_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[users_belong_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[puid]    ,[cuid]    ,[cduty]    ,[uid]    ,[bid]    ,[intime]    ,[deletetag]  	 FROM [users_belong]
	 WHERE ID=@id 



GO
