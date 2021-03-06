USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-16  
-- Description: 得到幼儿信息  
-- Memo:    
EXEC  user_GetChildModel 295765
*/ 
CREATE PROCEDURE [dbo].[user_GetChildModel]
	@userid int
AS 
BEGIN
	SELECT u.name,u.kid,uc.cid
	FROM [user] u
		inner join user_class uc 
			on u.userid = uc.userid
			and u.userid = @userid
END

GO
