USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_Delete]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-07-22
-- Description: 删除晨检枪参数设备信息
-- =============================================
CREATE PROCEDURE [dbo].[tcf_setting_Delete]
@id int
,@douserid int =0   
,@ipaddress nvarchar(150)='' 
AS
BEGIN

Delete [mcapp].[dbo].[tcf_setting]  
  Output Deleted.serialno,Deleted.kid,Deleted.xmsj,Deleted.lsavesj,Deleted.gunnum  
  ,Deleted.devid,Deleted.alarmt,Deleted.tox,Deleted.tax,Deleted.tx0A,Deleted.tx0B,Deleted.t5A  
  ,Deleted.t5B,Deleted.t10A,Deleted.t10B,Deleted.t15A,Deleted.t15B,Deleted.t20A,Deleted.t20B  
  ,Deleted.t25A,Deleted.t25B,Deleted.t30A,Deleted.t30B,Deleted.t35A,Deleted.t35B,Deleted.t40A  
  ,Deleted.t40B,Deleted.td40A,Deleted.td40B,Deleted.tx0C,Deleted.tx0,Deleted.t5C  
  ,Deleted.t5,Deleted.t10C,Deleted.t10,Deleted.t15C,Deleted.t15,Deleted.t20C,Deleted.t20  
  ,Deleted.t25C,Deleted.t25,Deleted.t30C,Deleted.t30,Deleted.t35C,Deleted.t35,Deleted.t40C  
  ,Deleted.t40,Deleted.td40C,Deleted.td40,Deleted.txMaxTW,Deleted.txMaxDif,Deleted.t25x1,
  Deleted.t25x2,Deleted.t25y1,Deleted.t25y2,@douserid,GETDATE(),@ipaddress
 into [mcapp].[dbo].[tcf_setting_log]([serialno],[kid],[xmsj],[lsavesj],[gunnum]  
  ,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]  
  ,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]  
  ,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]  
  ,[t40B],[td40A],[td40B],[tx0C],[tx0],[t5C]  
  ,[t5],[t10C],[t10],[t15C],[t15],[t20C],[t20]  
  ,[t25C],[t25],[t30C],[t30],[t35C],[t35],[t40C]  
  ,[t40],[td40C],[td40],[txMaxTW],[txMaxDif],t25x1,t25x2,t25y1,t25y2,douserid,dotime,ipaddress)    
 where id = @id
  
END



GO
