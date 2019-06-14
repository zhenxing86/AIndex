USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[jzxxuser_GetModelForApp]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[jzxxuser_GetModelForApp]             
 @userid int              
 AS               
BEGIN            
 SET NOCOUNT ON            
select headpic,uc.Nickname,Replace(uc.Account, 'jzxx', ''),uc.birthday,uc.gender,uc.jzxxgrade          
 from basicdata..[User] uc            
 where userid = @userid  and deletetag=1 and (roletype=3 or (account='jz1' ))       
END 
GO
