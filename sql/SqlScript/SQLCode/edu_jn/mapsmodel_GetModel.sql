USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[mapsmodel_GetModel]
@id int
 AS 
	SELECT 
	 1      ,kid    ,kname    ,mappoint    ,mapdesc    ,isgood  	 
	 FROM kininfoapp..kindergarten_condition
	 WHERE kid=@id 



GO
