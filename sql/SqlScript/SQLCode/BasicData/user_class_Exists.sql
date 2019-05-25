USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_class_Exists]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：是否存在用户班级关系记录 
--项目名称：
--说明：
--时间：2011-5-25 17:02:23
------------------------------------
CREATE PROCEDURE [dbo].[user_class_Exists]
@cid int,
@userid int
 AS 
	
	
	IF EXISTS(SELECT 1 FROM [user_class] WHERE cid=@cid AND userid=@userid)
	begin
		return (1)
	end
	else
	begin
		return (0)
	end





GO
