USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasciData_UserClass_GetListByUserID]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-7-27
-- Description:	获取管理员或园长 或者老师所在班级
-- =============================================
CREATE PROCEDURE [dbo].[BasciData_UserClass_GetListByUserID]
	@userid int,
	@isadmin bit
AS
BEGIN
	SET NOCOUNT ON
	IF (@isadmin=1)
	BEGIN	
		select t2.cname,t2.cid 
			from [user] t1 
				inner join class t2 
					on t1.kid = t2.kid
			where t1.userid = @userid
				AND t2.deletetag = 1
	END
	ELSE
	BEGIN
		select t2.cname,t2.cid 
			from user_class t1 
				inner join class t2 
					on t1.cid=t2.cid
			where t1.userid=@userid 
				AND t2.deletetag = 1     
END

END

GO
