USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_bbzx_video_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：宝宝在线查看班级视频权限设置 
--项目名称：ClassHomePage
--说明：
--时间：2010-10-11 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[T_bbzx_video_Update]
@userid int,
@actiontype int--0:添加和删除1:添加权限-1:删除权限
 AS 
	IF(@actiontype=0)
	BEGIN
		IF EXISTS(SELECT * FROM T_bbzx_video WHERE userid=@userid)
		BEGIN
			DELETE T_bbzx_video WHERE userid=@userid
		END
		ELSE
		BEGIN
			INSERT INTO T_bbzx_video(userid) values (@userid)
		END
	END
	ELSE IF(@actiontype=1)
	BEGIN
		DELETE T_bbzx_video WHERE userid=@userid
	END
	ELSE IF(@actiontype=(-1))
	BEGIN
		IF NOT EXISTS(SELECT * FROM T_bbzx_video WHERE userid=@userid)
		BEGIN
			INSERT INTO T_bbzx_video(userid) values (@userid)
		END
	END

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END


GO
