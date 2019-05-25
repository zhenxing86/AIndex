USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[TNB_ChapterRemark_GetModel]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[TNB_ChapterRemark_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[remarkid]    ,[chapterid]    ,[remarkcontent]    ,[userid]    ,[username]    ,[commentdatetime]    ,[deletetag]  	 FROM [TNB_ChapterRemark]
	 WHERE remarkid=@id 



GO
