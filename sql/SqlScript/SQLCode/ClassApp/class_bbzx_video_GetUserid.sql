USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_bbzx_video_GetUserid]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：取宝宝在线查看班级视频权限设置 
--项目名称：ClassHomePage
--说明：
--时间：2010-10-11 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_bbzx_video_GetUserid]
@userid int
 AS 
	return (1)
--	IF EXISTS(SELECT * FROM kmp..T_bbzx_video WHERE userid=@userid)
--	BEGIN
--	   RETURN(-1)
--	END
--	ELSE
--	BEGIN
--	   RETURN (1)
--	END





GO
