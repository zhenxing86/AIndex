USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[feestandard_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[kid]    ,[sname]    ,[describe]    
	 ,[price]    ,[isproxy]    ,[proxyprice]    
	 ,[isinvoice]    ,[uid]    ,[intime]    ,[a1]    
	 ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    
	 ,[a7]    ,[a8]    ,[remark]    ,[deletetag] ,a9,[a10],[a11],[a12],[a13] 	
	  FROM [feestandard]
	 WHERE ID=@id


GO
