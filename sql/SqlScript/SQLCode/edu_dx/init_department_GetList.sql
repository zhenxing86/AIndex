USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_department_GetList]    Script Date: 08/10/2013 10:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_department_GetList]
 AS 
	SELECT 
	       [did]    ,[dname]    ,[superior]    ,[order]    ,[deletetag]    ,[kid]    ,[actiondatetime]  	 FROM [department]
GO
