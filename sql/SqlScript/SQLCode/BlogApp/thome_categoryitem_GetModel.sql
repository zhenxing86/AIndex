USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_categoryitem_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-04 16:29:22
------------------------------------
CREATE PROCEDURE [dbo].[thome_categoryitem_GetModel]
@itemid int
 AS 
	SELECT 
	itemid,categoryid,userid,title,resultlevel
	 FROM thome_categoryitem
	 WHERE itemid=@itemid 







GO
