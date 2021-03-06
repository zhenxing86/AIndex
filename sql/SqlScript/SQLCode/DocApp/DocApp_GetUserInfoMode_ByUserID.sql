USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[DocApp_GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-06-28
-- Description: 获取用户基本信息
--exec DocApp_GetUserInfoMode_ByUserID 1
-- =============================================
CREATE PROCEDURE [dbo].[DocApp_GetUserInfoMode_ByUserID]
	@userid int
AS
BEGIN
	SET NOCOUNT ON     
	DECLARE @bloguserid int
	select @bloguserid = bloguserid 
		from BasicData..user_bloguser 
		where  userid = @userid

	select @userid as userid,u.name,u.kid,@bloguserid,u.usertype,t.sitedns  
	from BasicData..[user] u,
		kwebcms..[site] t
	where u.userid = @userid 
		and t.siteid = u.kid 
  END

GO
