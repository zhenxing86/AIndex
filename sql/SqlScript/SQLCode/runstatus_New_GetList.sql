USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[runstatus_New_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-06-08
-- Description:	获取设备最近运行状态信息
--[runstatus_New_GetList] 12511
-- =============================================
CREATE PROCEDURE [dbo].[runstatus_New_GetList] 
	@kid int
AS
BEGIN

 SELECT d.devid,oa.kid,oa.[status],oa.adate  
	 FROM mcapp..driveinfo d 
		OUTER apply(
			SELECT TOP(1)* 
				FROM mcapp..runstatus r 
				where d.devid = r.devid 
				ORDER BY r.adate DESC)oa
	 where d.kid = @kid

END

GO
