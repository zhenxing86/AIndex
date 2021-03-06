USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[ClassApp_GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-06-28
-- Description: 获取用户基本信息
--exec ClassApp_GetUserInfoMode_ByUserID 1
-- =============================================
CREATE PROCEDURE [dbo].[ClassApp_GetUserInfoMode_ByUserID]
	@userid int
AS
BEGIN
	SET NOCOUNT ON 
	DECLARE @bloguserid int
	select @bloguserid = bloguserid 
		from BasicData..user_bloguser 
		where userid = @userid

	select @userid as userid,u.name,u.kid,@bloguserid,u.usertype,s.sitedns  
		from BasicData..[user] u,
			kwebcms..[site] s
		where u.userid = @userid 
			and s.siteid = u.kid 
END

GO
