USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_remark_tmp_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询评语模板列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-20 14:25:54
------------------------------------
CREATE PROCEDURE [dbo].[thome_remark_tmp_GetList]
 AS 
	SELECT 
	id,remarkcontent,userid
	 FROM thome_remark_tmp







GO
