USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GBVideo_Update_FileSize]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的视频路径列表 
--exec GBVideos_Update_FileSize 191598
-- =============================================
CREATE PROCEDURE [dbo].[GBVideo_Update_FileSize]
AS
BEGIN
  UPDATE gbvideo SET filesize=vt.filesize,sceenshot=vt.sceenshot
    from gbvideo v inner join gbvideo_temp vt on v.[path] =vt.filepath
	
	delete gbvideo_temp
  
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
