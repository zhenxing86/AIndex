USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_remark_tmp_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到评语模板的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-20 14:25:54
------------------------------------
CREATE PROCEDURE [dbo].[thome_remark_tmp_GetModel]
@id int
 AS 
	SELECT 
	id,remarkcontent,userid
	 FROM thome_remark_tmp
	 WHERE id=@id 







GO
