USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_baseinfo_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 10:39:26
------------------------------------
CREATE PROCEDURE [dbo].[group_baseinfo_GetList]
 AS 
	SELECT 
	gid,kid,name,nickname,descript,logopic,mastename,inuserid,intime,[order],deletetag
	 FROM [group_baseinfo] where deletetag=1









GO
