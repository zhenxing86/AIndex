USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[department_GetModel]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：得到部门实体对象的详细信息 
--项目名称：OpenApp
--说明：
--时间：2011-5-19 9:28:39
------------------------------------
CREATE PROCEDURE [dbo].[department_GetModel]
@did int
 AS 
	SELECT 
		did,dname,superior,kid
	 FROM [department]
	 WHERE did=@did 






GO
