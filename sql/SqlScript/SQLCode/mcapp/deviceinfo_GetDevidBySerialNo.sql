USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_GetDevidBySerialNo]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-06-08  
-- Description: 新增  
-- =============================================  
create PROCEDURE [dbo].[deviceinfo_GetDevidBySerialNo]  
@serialno nvarchar(50)  
AS  
BEGIN  
  
 select top 1 devid   
 from mcapp..driveinfo   
 where serialno=@serialno  
  
END
GO
