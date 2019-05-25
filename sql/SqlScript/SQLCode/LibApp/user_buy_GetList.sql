USE [LibApp]
GO
/****** Object:  StoredProcedure [dbo].[user_buy_GetList]    Script Date: 2014/11/24 23:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[user_buy_GetList]
 @uid int
 AS 

SELECT  [catid]    ,[cat_title]    ,[css_name]    ,[parentid],index_view,cat_py,book_css,book_count,book_url  
	 FROM [lib_category]  
order by [catid] asc

GO
