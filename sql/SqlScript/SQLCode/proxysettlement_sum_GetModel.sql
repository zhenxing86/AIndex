USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[waitmoney]    ,[paymoney]    ,[paytype]    ,[payname]    ,[abid]    ,[city]    ,[paytimes]    ,[remark]    ,[uid]    ,[intime]    ,[deletetag]  	 FROM [proxysettlement_sum]
	 WHERE ID=@id 



GO
