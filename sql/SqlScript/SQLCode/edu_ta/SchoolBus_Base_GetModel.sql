USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Base_GetModel]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/16 11:39:06
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Base_GetModel]
@ID int
 AS 
	SELECT 
	ID,kid,number,regtime,unitname,cartype,carcolor,ishandle,allowtime,allowman,transfer,transfertimes,transferneedtime,transferalltime,transferman,information,stronginsuran,otherinsuran,maninsuran,inuserid,intime,numinsuran
	 FROM [SchoolBus_Base]
	 WHERE ID=@ID 









GO
