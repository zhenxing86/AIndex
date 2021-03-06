USE [SBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetReadRight]    Script Date: 2014/11/24 23:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-13
-- Description:	过程用于获取亲子阅读的权限
-- Memo:	GetReadRight 653612 
*/
CREATE PROCEDURE [dbo].[GetReadRight] 
	@userid int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		CASE WHEN CommonFun.dbo.fn_RoleGet(u.ReadRight,1) = 1 
						OR (CommonFun.dbo.fn_RoleGet(u.ReadRight,7) = 1 And ISNULL(g.gtype,0) not IN(1,2,3)) 
				 THEN '1' ELSE '0' END +','+
		CASE WHEN CommonFun.dbo.fn_RoleGet(u.ReadRight,2) = 1 
						OR (CommonFun.dbo.fn_RoleGet(u.ReadRight,8) = 1 And ISNULL(g.gtype,0) not IN(1,2,3)) 
				 THEN '1' ELSE '0' END  +','+
		cast(CommonFun.dbo.fn_RoleGet(u.ReadRight,3) as varchar(1))+','+
		cast(CommonFun.dbo.fn_RoleGet(u.ReadRight,4) as varchar(1))+','+
		cast(CommonFun.dbo.fn_RoleGet(u.ReadRight,5) as varchar(1))+','+ 
		cast(CommonFun.dbo.fn_RoleGet(u.ReadRight,6) as varchar(1))ReadRight
		FROM BasicData..[User] u 
			INNER JOIN BasicData..user_class uc on u.userid = uc.userid and u.usertype = 0
			INNER JOIN BasicData..class c on uc.cid = c.cid
			INNER JOIN BasicData..grade g ON c.grade = g.gid 
		WHERE u.userid = @userid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'过程用于获取亲子阅读的权限' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetReadRight'
GO
