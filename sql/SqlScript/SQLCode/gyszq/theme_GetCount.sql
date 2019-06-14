USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[theme_GetCount]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取模板总数
--项目名称：ServicePlatform
--说明：
--时间：2010-02-14 16:28:40
------------------------------------
CREATE PROCEDURE [dbo].[theme_GetCount]
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM theme  WHERE status=1
	RETURN @TempID
GO
