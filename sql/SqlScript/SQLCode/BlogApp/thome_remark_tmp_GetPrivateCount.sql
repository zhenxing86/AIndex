USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_remark_tmp_GetPrivateCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：私有评论模板总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-20 17:13:19
------------------------------------
CREATE PROCEDURE [dbo].[thome_remark_tmp_GetPrivateCount]
@userid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM thome_remark_tmp  WHERE userid=@userid
	RETURN @TempID	





GO
