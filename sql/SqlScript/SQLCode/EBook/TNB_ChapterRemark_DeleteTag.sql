USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[TNB_ChapterRemark_DeleteTag]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[TNB_ChapterRemark_DeleteTag]
@id int
 AS 
	update  [TNB_ChapterRemark] set deletetag=0
	 WHERE remarkid=@id 



GO
