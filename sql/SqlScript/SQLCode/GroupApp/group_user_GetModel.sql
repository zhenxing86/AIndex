USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetModel]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/24 9:34:59
------------------------------------
CREATE PROCEDURE [dbo].[group_user_GetModel]
@userid int
 AS 
	SELECT 
	1,userid,account,pwd,username,intime,deletetag,gid,did
	 FROM [group_user]
	 WHERE userid=@userid


GO
