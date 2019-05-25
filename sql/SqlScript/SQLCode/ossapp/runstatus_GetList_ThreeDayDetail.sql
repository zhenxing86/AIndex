USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[runstatus_GetList_ThreeDayDetail]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-06-08  
-- Description: 获取设备最近三天运行状态信息  
-- =============================================  
CREATE PROCEDURE [dbo].[runstatus_GetList_ThreeDayDetail]   
 @devid varchar(9)  
AS  
BEGIN  
 set nocount on  
 declare @total int =0
 
 select @total =COUNT(1) 
  FROM mcapp..runstatus  
  WHERE devid = @devid and adate>=DATEADD(day,-3,getdate())
 
 if @total<100
  set @total = 100
  
 SELECT top (@total) devid,kid,[status],adate  
  FROM mcapp..runstatus  
  WHERE devid = @devid  
  ORDER BY adate desc   
  
END  


GO
