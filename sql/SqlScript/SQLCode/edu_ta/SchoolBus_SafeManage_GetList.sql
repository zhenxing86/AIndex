USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManage_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/16 11:45:11
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManage_GetList]
 AS 
	SELECT 
	ID,bid,childsafe,teachersafe,carsafe,childinsuran,childeducation,teachereducation,opinion,inuserid,intime
	 FROM [SchoolBus_SafeManage]








GO
