USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_kindergarten_Delete]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除用户幼儿园记录 
--项目名称：
--说明：
--时间：2011-5-25 17:23:57
------------------------------------
CREATE PROCEDURE [dbo].[user_kindergarten_Delete]
@userid int,
@kid int
 AS  
 	if(@userid>0)
	begin
	  UPDATE [user] set kid = 0	 WHERE  userid=@userid
	end
	
	if(@kid>0)
	begin
	  UPDATE [user] set kid = 0	 WHERE  kid=@kid
	end

	IF(@@ERROR<>0)
	begin
		return (-1)
	end
	else
	begin
		return (1)
	end

GO
