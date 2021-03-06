USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetKindergartenByKname]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	按幼儿园名取幼儿园
-- Memo:
EXEC Manage_GetKindergartenByKname '晶晶大拇指幼儿园'
*/ 
CREATE PROCEDURE [dbo].[Manage_GetKindergartenByKname]
@kname nvarchar(500)
 AS
BEGIN
	SET NOCOUNT ON 	
	select	k.kid as ID,k.kname as Name,'' as Url,k.ActionDate,
					'' as Memo,u.userid as ID,u.account as LoginName,u.NickName
		FROM basicdata.dbo.Kindergarten k 
			INNER JOIN basicdata.dbo.[user] u 
				ON k.kid = u.kid
		WHERE k.kname like '%'+@kname+'%' 
			AND u.UserType = 98
END

GO
