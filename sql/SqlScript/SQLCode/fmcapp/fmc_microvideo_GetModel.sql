USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_microvideo_GetModel]    Script Date: 06/18/2013 18:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：获取专家讲坛信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 
--时间：2013-6-17 15:50:29
--exec fmc_microvideo_GetModel 1
------------------------------------
ALTER PROCEDURE [dbo].[fmc_microvideo_GetModel]
@id int
 AS 
	SELECT 1,[ID],title,describe,smallimg,url,[uid],intime,click,deletetag
	 FROM [fmc_microvideo]
	 WHERE ID=@id 




