USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManage_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/16 11:45:11
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManage_GetModel]
@ID int
 AS 
	SELECT 
	ID,bid,childsafe,teachersafe,carsafe,childinsuran,childeducation,teachereducation,opinion,inuserid,intime
	 FROM [SchoolBus_SafeManage]
	 WHERE ID=@ID 










GO
