USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_expertsforum_GetModel]    Script Date: 06/18/2013 18:05:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：获取专家讲坛信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 
--时间：2013-6-17 15:50:29
--exec fmc_expertsforum_GetModel 1
------------------------------------
ALTER PROCEDURE [dbo].[fmc_expertsforum_GetModel]
@id int
 AS 
	SELECT 1,[ID],expertid,title,describe,smallimg,url,[uid],intime,click,deletetag
	 FROM [fmc_expertsforum]
	 WHERE ID=@id and deletetag =1



