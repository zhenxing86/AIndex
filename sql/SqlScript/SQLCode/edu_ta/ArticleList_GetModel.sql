USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：查询记录信息 
--项目名称：ArticleList
------------------------------------
CREATE PROCEDURE [dbo].[ArticleList_GetModel]
	@ID int 
	 AS
	
	
	SELECT 1,[ID],[typeid],[title],[body],[describe],
	[autor],[level],[isMaster],[orderID],[reMark],[uid],[createtime],[deletetag]   
	FROM [ArticleList] 
	where  id = @ID









GO
