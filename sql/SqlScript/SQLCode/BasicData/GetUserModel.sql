USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date: 2011-6-20
-- Description:	获取用户实体 
-- =============================================
ALTER PROCEDURE GetUserModel
	@userid int
AS
BEGIN
	SET NOCOUNT ON
  select	userid, account, [password], usertype, r.kid, 
					case	when CommonFun.dbo.fn_RoleGet(RoleType,1) = 1 then 1 
								when CommonFun.dbo.fn_RoleGet(RoleType,2) = 1 then 2 
					end RoleType,isnull(b.ptype,0) ptype
		from [user] r
		left join blogapp..permissionsetting b on b.kid=r.kid and b.ptype=81
		where userid = @userid
END
GO
GetUserModel 288557


