USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[kid]    ,[settlementtype]    ,[settlementname]    ,[paytype]    ,[settlementmoney]    ,[waitmoney]    ,[paytimes]    ,[abid]    ,[remark]    ,[uid]    ,[intime]    ,[deletetag]  	 FROM [proxysettlement]
	 WHERE ID=@id 



GO
