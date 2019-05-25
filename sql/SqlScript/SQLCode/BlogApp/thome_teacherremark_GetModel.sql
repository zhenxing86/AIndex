USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_teacherremark_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-04 11:32:20
------------------------------------
CREATE PROCEDURE [dbo].[thome_teacherremark_GetModel]
@bloguserid int,
@categoryid int
 AS 
	SELECT 
	remarkid,categoryid,userid,remarkcontent,totallevel
	 FROM thome_teacherremark
	 WHERE userid=@bloguserid and categoryid=@categoryid







GO
