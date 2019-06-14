USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kindomain_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[kindomain_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[id]    ,[KID]    ,[kindergarten]    ,[recordNo]    ,[recordName]    ,[recordPwd]    ,[purchaseDate]    ,[endDate]    ,[websiteName]    ,[websitePwd]    ,[domainName]    ,[documentsNo]    ,[personName]    ,[personDocumentNo]    ,[phone]    ,[tel]    ,[email]    ,[address]    ,[payment]    ,[remark]    ,[audit]    ,[status]    ,[DNSAddress]    ,[SPName]    ,[isown]  	 FROM [kindomain]
	 WHERE kid=@id 



GO
