USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoicemanage_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[invoicemanage_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[kid]    ,[ismail]    ,[isapplicant]    ,[isinvoice]    ,[istax]    ,[mailaddress]    ,[invoicetitle]    ,[iname]    ,[tel]    ,[qq]    ,[uid]    ,[deletetag]  	 FROM [invoicemanage]
	 WHERE ID=@id 



GO
