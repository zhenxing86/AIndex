USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_Delete]    Script Date: 2014/11/24 23:19:16 ******/
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
create PROCEDURE [dbo].[tcf_setting_Delete]
@id int
AS
BEGIN

delete from [mcapp].[dbo].[tcf_setting]
  where id = @id

END



GO
