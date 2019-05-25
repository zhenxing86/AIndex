USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[payinfo_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[kid]    ,[kname]    ,[payby]    ,[paytype]    ,[money]    ,[paytime]    ,[isinvoice]    ,[invoicedec]    ,[uid]    ,[remark]    ,[isproxy]    ,[proxymoney]    ,[firsttime]    ,[lasttime]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[deletetag]  	 FROM [payinfo]
	 WHERE ID=@id 



GO
