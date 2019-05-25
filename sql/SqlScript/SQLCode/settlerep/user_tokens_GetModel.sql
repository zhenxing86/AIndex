USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[user_tokens_GetModel]    Script Date: 08/10/2013 10:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
Create PROCEDURE [dbo].[user_tokens_GetModel]
@token varchar(200)
 AS 
	SELECT 
	 1      ,[token]    ,[info]    ,[createdatetime]   
 ,[expiredatatime]  	 FROM [user_tokens]
	 WHERE [token]=@token  and datediff(ss,getdate(),[expiredatatime])>0
GO
