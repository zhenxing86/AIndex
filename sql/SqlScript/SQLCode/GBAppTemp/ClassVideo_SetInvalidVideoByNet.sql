USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ClassVideo_SetInvalidVideoByNet]    Script Date: 2014/11/24 23:08:44 ******/
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
CREATE PROCEDURE [dbo].[ClassVideo_SetInvalidVideoByNet] (@net int)
AS
BEGIN
  update video_temp set [status]=0   where net=@net and not exists (select 1 from classapp..class_video v 
where v.[filename]=video_temp.[filename])
  
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
