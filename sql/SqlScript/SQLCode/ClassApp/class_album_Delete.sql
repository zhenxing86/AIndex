USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除相册
--项目名称：ClassHomePage
--说明：
--时间：-1-6 10:58:57
------------------------------------
CREATE PROCEDURE [dbo].[class_album_Delete]
@albumid int,
@userid int,
@isblogalbum int
 AS 

	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION		
	
	DECLARE @kid int
	DECLARE @classid INT
	--SELECT @kid=kid,@classid=classid FROM class_album WHERE albumid=@albumid 

			--删除相片评论
--			UPDATE  t1 SET status=-1 from   class_photocomments t1
--		    INNER JOIN  class_photos  t2  on t1.photoid=t2.photoid 
--		    WHERE t2.albumid=@albumid
			

			--删除相片
			--UPDATE class_photos SET status=-1 WHERE albumid=@albumid
			 
			--删除相册
			UPDATE class_album SET status=-1 WHERE albumid=@albumid

			--删除日志记录
			delete applogs..class_log where actionobjectid=@albumid and actiontypeid=1
			--exec [class_actionlogs_Delete] @albumid,21

	IF @@ERROR <> 0 
	BEGIN	
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION		
	   RETURN (1)
	END



GO
