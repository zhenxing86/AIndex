USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_ArticleList_GetListModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[UI_ArticleList_GetListModel]
 @aid int
 AS 

update [ArticleList] set clickcount=clickcount+1 where ID=@aid

SELECT 
	1      ,l.[ID]    ,[typeid]    ,[title]    ,[body]    ,l.[describe]    ,[autor]    ,l.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,l.[createtime]    ,[deletetag],clickcount  	 FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and l.[ID]=@aid







GO
