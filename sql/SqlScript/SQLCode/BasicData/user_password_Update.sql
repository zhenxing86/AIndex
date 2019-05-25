USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_password_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：修改一条用户密码信息记录 
--项目名称：
--说明：
--时间：2011-5-25 17:57:18
------------------------------------
CREATE PROCEDURE [dbo].[user_password_Update]
@userid int,
@password nvarchar(50)
 AS 
	update [user] set [password]=@password where userid=@userid
	
	if(@@ERROR<>0)
	begin
		return (-1)
	end
	else
	begin
		return (1)
	end 




GO
