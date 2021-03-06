USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildCountByNameAndUserid_leave]    Script Date: 2014/11/24 21:18:47 ******/
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
EXEC @count = user_GetChildCountByNameAndUserid_leave '',295765
SELECT @count
*/
CREATE PROCEDURE [dbo].[user_GetChildCountByNameAndUserid_leave]
	@name nvarchar(20),
	@userid  int
AS
BEGIN 
	Declare @count int
	SELECT @count=count(1) FROM	[user] u 
		left join leave_kindergarten lk on u.userid = lk.userid
	WHERE u.usertype = 0   
		and lk.userid = @userid
		and lk.userid is not null
		and u.name like @name+'%'
		and u.deletetag=1
	RETURN @count
END

GO
