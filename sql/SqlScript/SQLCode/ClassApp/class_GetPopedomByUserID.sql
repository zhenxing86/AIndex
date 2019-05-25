USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetPopedomByUserID]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取班级后台操作权限
--项目名称：classhomepage
--时间：2009-03-09 14:23:01
------------------------------------
CREATE PROCEDURE [dbo].[class_GetPopedomByUserID]
@userid int
 AS	
		DECLARE @usertype int
		DECLARE @kid int

		SELECT @usertype=usertype FROM BasicData.dbo.[user] WHERE userid=@userid		
		IF(@usertype=97 or @usertype=98)
		BEGIN
			RETURN (1)--管理员、园长
		END		
		ELSE IF(@usertype=1)
		BEGIN
			RETURN (2)--老师
		END
		ELSE
		BEGIN	
			RETURN (0)
		END







GO
