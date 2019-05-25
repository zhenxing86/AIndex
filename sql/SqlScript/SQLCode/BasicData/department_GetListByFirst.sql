USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_GetListByFirst]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询一级部门记录信息 
--项目名称：OpenApp
--说明：
--时间：2011-5-19 9:28:39
------------------------------------
CREATE PROCEDURE [dbo].[department_GetListByFirst]
@kid int
 AS 
	SELECT 
	did,dname,superior
	 FROM [department]
	 WHERE kid=@kid and deletetag=1 and superior=0 
	 ORDER BY [order] DESC




GO
