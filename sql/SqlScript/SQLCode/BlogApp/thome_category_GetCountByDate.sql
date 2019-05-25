USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_category_GetCountByDate]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询记录信息 
--项目名称：zgyeyblog
--说明：
--时间：2008-09-23 13:14:22
------------------------------------
CREATE PROCEDURE [dbo].[thome_category_GetCountByDate]
@periodid int,
@kid int,
@date datetime
 AS 

	DECLARE @TempID int
	SELECT 
	@TempID = count(1)
	 FROM thome_category
	WHERE period=@periodid and kid=@kid and startdate<=@date and enddate>=@date

	RETURN @TempID





GO
