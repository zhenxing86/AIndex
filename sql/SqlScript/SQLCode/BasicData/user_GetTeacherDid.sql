USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherDid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到老师对象的部门 
--项目名称：
--说明：
--时间：2011-5-20 16:57:46
------------------------------------
CREATE PROCEDURE [dbo].[user_GetTeacherDid]
@userid int
 AS 
	SELECT 	did	 FROM teacher
	 WHERE userid=@userid 
	 
	 




GO
