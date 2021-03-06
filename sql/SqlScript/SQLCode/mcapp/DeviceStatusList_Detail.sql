USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[DeviceStatusList_Detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  yz  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROC [dbo].[DeviceStatusList_Detail]  
  @devid varchar(9)  
AS  
BEGIN  
	SET NOCOUNT ON;  
	select r.adate as heartbeattime  
		from runstatus r  
		where r.devid = @devid  
			and r.adate >= DATEADD(SS,-1800,GETDATE())  
		order by heartbeattime desc  
END  
GO
