USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_getperiodlist]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取家园联系期列表
--项目名称：zgyeyblog
--说明：
--时间：2008-09-23 13:14:22
------------------------------------
CREATE PROCEDURE [dbo].[thome_getperiodlist]
 AS 
	SELECT 
	periodid,title
	 FROM thome_period	









GO
