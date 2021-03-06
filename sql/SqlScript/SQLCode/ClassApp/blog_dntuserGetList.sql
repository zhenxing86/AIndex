USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_dntuserGetList]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-07
-- Description: 取博客论坛用户	
-- Memo:
exec blog_dntuserGetList 5740
*/
CREATE PROCEDURE [dbo].[blog_dntuserGetList]
	@kid int
 AS
BEGIN
	SET NOCOUNT ON 
	select bd.dntuserid, bd.kmpuserid, u.nickname 
		from blog_dntuser bd 
			left join basicdata..[user] u 
				on bd.kmpuserid = u.userid
		where bd.kid = @kid 
			and u.deletetag = 1
END

GO
