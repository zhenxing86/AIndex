USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetModelByAccountAndPassowrd]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询记录信息 
--项目名称：Account
------------------------------------
create PROCEDURE [dbo].[group_user_GetModelByAccountAndPassowrd]
	@returnvalue int output,
	  		@account varchar(100),
	  		@password varchar(200)
	  		
	 AS
	
	SELECT 
	1,userid,account,pwd,username,intime,deletetag,gid,did
	 FROM [group_user]
	 WHERE account=@account and pwd=@password
	
	
	
	
	
	--SELECT 1, [ID],   [account],   [password],   [uname],   [regdatetime],   [lastlogindatetime],   [deletetag] ,[webDictID]
 --   FROM [Account]
 --   where account=@account and password=@password
    

	RETURN 0

GO
