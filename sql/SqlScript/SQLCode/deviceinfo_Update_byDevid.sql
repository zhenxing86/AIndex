USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_Update_byDevid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-06-08
-- Description:	更新设备信息
-- =============================================
CREATE PROCEDURE [dbo].[deviceinfo_Update_byDevid]
@devid	nvarchar(9),
@kid	int,
@sno	nvarchar(50),
@scode	nvarchar(32),
@maddr	nvarchar(150),
@saddr	nvarchar(150),
@adupt	int,
@msms	int,
@tsms	int,
@psms	int,
@interval	int,
@wifi	nvarchar(50),
@photo	int,
@firmw	nvarchar(150),
@daddr	nvarchar(150),
@pcfirmw	nvarchar(150),
@pcdaddr	nvarchar(150)
	
AS
BEGIN

 --update mcapp..driveinfo 
	--set devid=@devid,kid=@kid,sno=@sno,scode=@scode,maddr=@maddr,
	--saddr=@saddr,adupt=@adupt,msms=@msms,tsms=@tsms,psms=@psms,
	--interval=@interval,wifi=@wifi,photo=@photo,firmw=@firmw,
	--daddr=@daddr,pcfirmw=@pcfirmw,pcdaddr=@pcdaddr
 --   where devid = @devid
    
 update mcapp..driveinfo 
	set sno=@sno,scode=@scode,maddr=@maddr,saddr=@saddr,
	wifi=@wifi,photo=@photo,firmw=@firmw,daddr=@daddr,pcfirmw=@pcfirmw,pcdaddr=@pcdaddr,interval=@interval
    where devid = @devid
    
 exec config_manage_Update 9,1
END

GO
