USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[user_tokens_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[user_tokens_GetModel]
@token varchar(200)
 AS 
	SELECT top 1
	 1      ,[token]    ,[info]    ,[createdatetime]   
 ,[expiredatatime]  	 FROM [user_tokens]
	 WHERE [token]=@token order by  [createdatetime] desc--and datediff(ss,getdate(),[expiredatatime])>0









GO
