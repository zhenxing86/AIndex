USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：删除一条记录 
--项目名称：ArticleType
------------------------------------
CREATE PROCEDURE [dbo].[ArticleType_Delete]
  @ID int                            	
 AS 
	DELETE [ArticleType]
	 WHERE   [ID] = @ID                            	








GO
