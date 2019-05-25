USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetListTagByids]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[kinbaseinfo_GetListTagByids]
@ids varchar(max)
 AS 

SELECT 
	[ID]    ,[kid]    ,[kname] ,dbo.agentbase_waitmoney(kid)

  FROM [kinbaseinfo]  
where deletetag=1 and  ','+@ids+',' like '%,'+convert(varchar,kid)+',%' 


GO
