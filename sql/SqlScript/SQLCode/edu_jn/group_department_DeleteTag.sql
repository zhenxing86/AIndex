USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_department_DeleteTag]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[group_department_DeleteTag]
@did int
 AS 
	update [group_department] set deletetag=0
	 WHERE did=@did








GO
