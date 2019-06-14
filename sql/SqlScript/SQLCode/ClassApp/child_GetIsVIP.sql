USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[child_GetIsVIP]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：是否是VIP
--项目名称：ClassHomePage
--说明：
--时间：2009-3-17 11:50:29
------------------------------------
CREATE PROCEDURE [dbo].[child_GetIsVIP]
@userid int
 AS 
	IF EXISTS(SELECT 1 from BasicData.dbo.child WHERE userid=@userid AND vipstatus=1)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (0)
	END









GO
