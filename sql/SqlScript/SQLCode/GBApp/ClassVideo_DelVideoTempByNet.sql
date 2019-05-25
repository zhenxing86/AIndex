USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ClassVideo_DelVideoTempByNet]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的无效视频列表 
--exec ClassVideo_Set_Invalid_Videos 191598
-- =============================================
CREATE PROCEDURE [dbo].[ClassVideo_DelVideoTempByNet] (@net int)
AS
BEGIN
  delete from gbapp..video_temp where net=@net 
  
  IF @@ERROR <> 0 
  BEGIN 
	RETURN -1
  END
  ELSE
  BEGIN
	RETURN 1
  END

END


GO
