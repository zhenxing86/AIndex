USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_GetCount]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取公告总数
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE  PROCEDURE [dbo].[class_notice_GetCount]
@classid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_notice_class WHERE classid=@classid
	RETURN @TempID	






GO
