USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[T_bbzx_video_class_Update]    Script Date: 2014/11/24 23:13:55 ******/
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
create PROCEDURE [dbo].[T_bbzx_video_class_Update]
@classid int,
@actiontype int--1:添加权限-1:删除权限
 AS 
	
	IF(@actiontype=1)
	BEGIN
		DELETE FROM T_bbzx_video  FROM  T_bbzx_video t1 INNER JOIN basicdata..user_class t2 ON t1.userid=t2.userid  WHERE t2.cid=@classid
	END
	ELSE IF(@actiontype=(-1))
	BEGIN
		INSERT INTO T_bbzx_video(userid) SELECT t1.userid FROM basicdata..user_class  t1 left join T_bbzx_video t2 on t1.userid=t2.userid WHERE t1.cid=@classid and t2.userid is null
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'T_bbzx_video_class_Update', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
