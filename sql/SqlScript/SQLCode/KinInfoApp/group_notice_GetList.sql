USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetList]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_GetList]
 AS 
	SELECT 
	nid,title,content,istype,inuserid,intime,deletetag
	 FROM [group_notice]










GO
