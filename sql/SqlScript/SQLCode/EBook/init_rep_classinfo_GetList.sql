USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_classinfo_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_rep_classinfo_GetList]
 AS 
	SELECT 
	       [kid]    ,[kname]    ,[gradeid]    ,[gradename]    ,[cid]    ,[cname]    ,[areaid]  	 FROM [rep_classinfo]
	


GO
