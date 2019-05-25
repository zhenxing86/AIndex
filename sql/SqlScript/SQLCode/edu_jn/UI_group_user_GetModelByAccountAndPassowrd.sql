USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_group_user_GetModelByAccountAndPassowrd]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UI_group_user_GetModelByAccountAndPassowrd]
	@returnvalue int output,
	  		@account varchar(100),
	  		@password varchar(200)
	  		
	 AS
	
	SELECT 
	1,userid,account,pwd,username,intime,deletetag,1,did
	 FROM [group_user]
	 WHERE account=@account and pwd=@password
	
	union all 
     select 1,userid,account,password,'','',1,'','' from BasicData..[user]
	 WHERE account=@account and password=@password



GO
