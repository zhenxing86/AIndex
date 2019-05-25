USE [ResourceApp]
GO
/****** Object:  StoredProcedure [dbo].[course_content_GetSubtypeCount]    Script Date: 2014/11/24 23:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取互动学堂系列课件数
--项目名称：CLASSHOMEPAGE
--说明：
--时间：2009-3-29 22:30:07
------------------------------------
CREATE PROCEDURE [dbo].[course_content_GetSubtypeCount]
@subtypeid int,
@isvip int
AS
	
	DECLARE @count int
	IF(@isvip=1)
	BEGIN
		SELECT @count=count(1) FROM course_content WHERE subtypeno=@subtypeid
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM course_content WHERE subtypeno=@subtypeid AND status <>1
	END
	RETURN @count






GO
