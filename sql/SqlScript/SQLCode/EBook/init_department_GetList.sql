USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_department_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_department_GetList]
 AS 
	SELECT 
	       [did]    ,[dname]    ,[superior]    ,[order]    ,[deletetag]    ,[kid]    ,[actiondatetime]  	 FROM [department]
	


GO
