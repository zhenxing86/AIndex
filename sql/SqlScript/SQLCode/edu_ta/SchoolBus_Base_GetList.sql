USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Base_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/16 11:39:06
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Base_GetList]
 AS 
	SELECT 
	ID,kid,number,regtime,unitname,cartype,carcolor,ishandle,allowtime,allowman,transfer,transfertimes,transferneedtime,transferalltime,transferman,information,stronginsuran,otherinsuran,maninsuran,inuserid,intime
	 FROM [SchoolBus_Base]
 where deletetag=1








GO
