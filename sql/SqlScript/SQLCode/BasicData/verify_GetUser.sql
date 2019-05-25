USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xzx
-- Project: com.zgyey.verify
-- Create date: 2013-06-05
-- Description:	获取用户信息
-- =============================================
alter PROCEDURE dbo.varify_GetUser
	@account nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON
	
	select u.account, ub.name, ub.mobile, u.userid 
		from BasicData..[user] u
			inner join BasicData..user_baseinfo ub 
				on u.userid = ub.userid
		where u.account = @account 
			and u.deletetag = 1
END
GO



