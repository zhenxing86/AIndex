USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_bloglist_GetList]    Script Date: 08/10/2013 10:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_bloglist_GetList]
 AS 
	SELECT 
	       [postid]    ,[userid]    ,[title]    ,[author]    ,[kname]    ,[sitedns]    ,[postdatetime]    ,[usertype]    ,[areaid]  	 FROM [bloglist]
GO
