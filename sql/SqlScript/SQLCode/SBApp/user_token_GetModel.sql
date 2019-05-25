USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[user_token_GetModel]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[user_token_GetModel] 
@token varchar(200)
 AS 
	SELECT 
	 [token],info    FROM  AppLogs..user_tokens
	 WHERE [token]=@token  and datediff(ss,getdate(),[expiredatatime])>0
	 




GO
