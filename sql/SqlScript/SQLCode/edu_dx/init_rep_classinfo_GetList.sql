USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_classinfo_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_rep_classinfo_GetList]
 AS 
	SELECT 
	       [kid]    ,[kname]    ,[gradeid]    ,[gradename]    ,[cid]    ,[cname]    ,[areaid]  	 FROM [rep_classinfo]
GO
