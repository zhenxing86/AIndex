USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_bloglist_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_bloglist_GetList]
 AS 
	SELECT 
	       [postid]    ,[userid]    ,[title]    ,[author]    ,[kname]    ,[sitedns]    ,[postdatetime]    ,[usertype]    ,[areaid]  	 FROM [bloglist]
	


GO
