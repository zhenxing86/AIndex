USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_bbzx_video_class_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：更改宝宝在线班级视频权限设置 
--项目名称：ClassHomePage
--说明：
--时间：2010-10-11 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[T_bbzx_video_class_Update]
@classid int,
@actiontype int--1:添加权限-1:删除权限
 AS 
	
	IF(@actiontype=1)
	BEGIN
		DELETE FROM T_bbzx_video  FROM  T_bbzx_video t1 INNER JOIN T_child t2 ON t1.userid=t2.userid  WHERE t2.classid=@classid
	END
	ELSE IF(@actiontype=(-1))
	BEGIN
		INSERT INTO T_bbzx_video(userid) SELECT t1.userid FROM T_child t1 left join T_bbzx_video t2 on t1.userid=t2.userid WHERE t1.classid=@classid and t1.status=1 and t2.userid is null
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
