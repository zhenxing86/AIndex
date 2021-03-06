USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildCountByNameAndUserid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description:  得到用户列表 
-- Memo:  
DECLARE @count int
EXEC @count = user_GetChildCountByNameAndUserid '',295765
SELECT @count
*/
CREATE PROCEDURE [dbo].[user_GetChildCountByNameAndUserid]
	@name nvarchar(20),
	@userid  int
AS
BEGIN 
	Declare @count int
	SELECT @count = count(1) 
		FROM [user] u 
			Inner JOIN user_class uc1 on u.userid = uc1.userid
			inner join user_class uc2  on uc1.cid = uc2.cid
			left join leave_kindergarten lk on u.userid = lk.userid
		WHERE u.usertype = 0 
			and u.deletetag = 1  
			and uc2.userid = @userid 
			and u.name like @name+'%'
			and lk.userid is null
	RETURN @count
END

GO
