USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfolog_GetListTagByplids]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[payinfolog_GetListTagByplids]
@plids varchar(1000)
 AS 


exec('
SELECT  1,[ID]    ,[pid]    ,[kid]    ,[kname]    ,[payby]    ,[paytype]    ,[money]    ,[paytime]    ,[isinvoice]    ,[invoicedec]    ,[uid]    ,[remark]    ,[isproxy]    ,[proxymoney]    ,[firsttime]    ,[lasttime]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[deletetag]  	 
FROM [payinfolog]  
where deletetag=1
 and [ID] in ('+@plids+') order by ID desc')






GO
