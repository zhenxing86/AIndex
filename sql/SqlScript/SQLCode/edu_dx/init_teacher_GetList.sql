USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_teacher_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_teacher_GetList]
 AS 
	SELECT 
	       [userid]    ,[did]    ,[title]    ,[post]    ,[education]    ,[employmentform]    ,[politicalface]    ,[kinschooltag]  	 FROM [teacher]
GO
