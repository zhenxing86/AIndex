USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_child_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_child_GetList]
 AS 
	SELECT 
	       [userid]    ,[fathername]    ,[mothername]    ,[favouritething]    ,[fearthing]    ,[favouritefoot]    ,[footdrugallergic]    ,[vipstatus]    ,[email]    ,[address]    ,[istip]    ,[exigencetelphone]  	 FROM [child]
	


GO
