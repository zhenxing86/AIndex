USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_UpdateSerialno]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-06-08
-- Description:	更新设备编号
-- =============================================
CREATE PROCEDURE [dbo].[deviceinfo_UpdateSerialno]
@devid	nvarchar(9),
@kid	int,
@serialno	nvarchar(50)
AS
BEGIN

 --if not exists (select 1 from mcapp..driveinfo where serialno=@serialno and devid<>@devid)
 --begin
	-- --update mcapp..driveinfo 
	--	--set serialno=@serialno
	--	--where devid=@devid
	--	-- and kid = @kid
 --end 
 --else
 --begin
	--return -1
 --end
	 
 if @@ERROR<>0 
  return -1
 else 
  return 1
 
END
GO
