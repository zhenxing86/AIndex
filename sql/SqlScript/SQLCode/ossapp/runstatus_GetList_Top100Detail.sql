USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[runstatus_GetList_Top100Detail]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-06-08
-- Description:	获取设备100条运行状态信息
-- =============================================
CREATE PROCEDURE [dbo].[runstatus_GetList_Top100Detail] 
	@devid varchar(9)
AS
BEGIN
	set nocount on
	SELECT top 100 devid,kid,[status],adate
		FROM mcapp..runstatus
		WHERE devid = @devid
		ORDER BY adate desc 

END

GO
