USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetIsClassTeacher]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：是否为本班老师
--项目名称：classhomepage
--时间：2009-02-23 9:23:01
------------------------------------
CREATE PROCEDURE [dbo].[class_GetIsClassTeacher]
@userid int,
@classid int
 AS	
	
	IF EXISTS(SELECT 1 FROM BasicData.dbo.user_class t1 left join basicdata..[user] t2 on t1.userid=t2.userid WHERE t1.userid=@userid AND t1.cid=@classid and t2.usertype>0)
		BEGIN
			RETURN 1
		END
		ELSE
		BEGIN
			RETURN 0
		END
	




GO
