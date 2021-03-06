USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[deviceinfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-06-08
-- Description:	根据id获取设备信息
-- =============================================
CREATE PROCEDURE [dbo].[deviceinfo_GetModel]
@id int
AS
BEGIN

 select devid,kid,sno,scode,maddr,saddr,adupt,msms,tsms,
	psms,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,
	serialno,id,showphoto,cardone,playcname,devicetype
    from mcapp..driveinfo 
    where id = @id
END


GO
