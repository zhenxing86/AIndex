USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Driver_GetModelByBid]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SchoolBus_Driver_GetModelByBid]
@BID int
 AS 
	SELECT 
	ID,bid,name,sex,age,cardno,driveinfo,tel,driveno,cartype,driveage,healthy,inserid,intime
	 FROM [SchoolBus_Driver]
	 WHERE bid=@BID and deletetag=1









GO
