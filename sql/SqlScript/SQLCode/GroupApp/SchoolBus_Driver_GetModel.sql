USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Driver_GetModel]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/16 11:44:02
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Driver_GetModel]
@ID int
 AS 
	SELECT 
	ID,bid,[name],sex,age,cardno,driveinfo,tel,driveno,cartype,driveage,healthy,inserid,intime
	 FROM [SchoolBus_Driver]
	 WHERE ID=@ID 




GO
