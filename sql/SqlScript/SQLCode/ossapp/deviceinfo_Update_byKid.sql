USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_Update_byKid]    Script Date: 06/14/2013 10:46:30 ******/
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
alter PROCEDURE [dbo].[deviceinfo_Update_byKid]
@devid	nvarchar(9),
@kid	int,
@sno	nvarchar(50),
@scode	nvarchar(32),
@maddr	nvarchar(50),
@saddr	nvarchar(50),
@adupt	int,
@msms	int,
@tsms	int,
@psms	int,
@interval	int,
@wifi	nvarchar(50),
@photo	int,
@firmw	nvarchar(50),
@daddr	nvarchar(50),
@pcfirmw	nvarchar(50),
@pcdaddr	nvarchar(50)
	
AS
BEGIN

 --update mcapp..driveinfo 
	--set devid=@devid,kid=@kid,sno=@sno,scode=@scode,maddr=@maddr,
	--saddr=@saddr,adupt=@adupt,msms=@msms,tsms=@tsms,psms=@psms,
	--interval=@interval,wifi=@wifi,photo=@photo,firmw=@firmw,
	--daddr=@daddr,pcfirmw=@pcfirmw,pcdaddr=@pcdaddr
 --   where devid = @devid
    
 update mcapp..driveinfo 
	set scode=@scode,maddr=@maddr,saddr=@saddr,msms=@msms,tsms=@tsms,psms=@psms,
	wifi=@wifi,photo=@photo,firmw=@firmw,daddr=@daddr,pcfirmw=@pcfirmw,pcdaddr=@pcdaddr,interval=@interval
    where kid=@kid
END