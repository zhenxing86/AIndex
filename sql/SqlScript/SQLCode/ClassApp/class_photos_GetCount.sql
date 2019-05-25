USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_GetCount]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：取相片总数
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE  PROCEDURE [dbo].[class_photos_GetCount]
@albumid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_photos WHERE albumid=@albumid AND status=1
	RETURN @TempID	







GO
