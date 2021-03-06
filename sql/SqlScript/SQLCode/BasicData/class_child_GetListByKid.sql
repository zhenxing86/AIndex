USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_child_GetListByKid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-01
-- Description:	取学校学生
-- Memo:		
class_child_GetListByKid 12511
*/
CREATE PROCEDURE [dbo].[class_child_GetListByKid]
	@kid int
AS
BEGIN
	SET NOCOUNT ON
	select u.userid, u.name, uc.cid
		From basicdata.dbo.[user] u 
		inner join basicdata.dbo.user_class uc 
			on u.userid = uc.userid	
		where u.kid = @kid 
			and u.deletetag = 1 
			and u.usertype = 0 
		order by u.userid
END

GO
