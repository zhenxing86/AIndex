USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_GetModel_BySerialNO]    Script Date: 09/23/2013 19:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-09-23
-- Description:	根据serialno获取晨检枪参数设备信息实体
-- =============================================
create PROCEDURE [dbo].[tcf_setting_GetModel_BySerialNO]
@serialno nvarchar(20)
AS
BEGIN

SELECT [id],[serialno],[kid],[xmsj],[lsavesj],[gunnum]
,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]
,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]
,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]
,[t40B],[td40A],[td40B]
  FROM [mcapp].[dbo].[tcf_setting]
  where serialno = @serialno

END



