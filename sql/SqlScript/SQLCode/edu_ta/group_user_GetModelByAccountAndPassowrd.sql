USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetModelByAccountAndPassowrd]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：查询记录信息 
--项目名称：Account
------------------------------------
CREATE PROCEDURE [dbo].[group_user_GetModelByAccountAndPassowrd]
	  		@account varchar(100),
	  		@password varchar(200)
	  		
	 AS
	
	SELECT 
	1,userid,account,'1',username,intime,deletetag,0,did
	 FROM [group_user]
	 WHERE account=@account and pwd=@password and deletetag =1

	


GO
