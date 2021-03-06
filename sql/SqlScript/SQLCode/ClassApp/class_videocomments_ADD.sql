USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_videocomments_ADD]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加视频评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:53:32
------------------------------------
CREATE PROCEDURE [dbo].[class_videocomments_ADD]
@videoid int,
@userid int,
@author nvarchar(50),
@content ntext,
@parentid int

 AS 

	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	INSERT INTO class_videocomments(
	[videoid],[userid],[author],[content],[commentdatetime],[parentid],[status]
	)VALUES(
	@videoid,@userid,@author,@content,getdate(),@parentid,1
	)

	--更新照片评论数量	
	UPDATE class_video SET [commentcount]=[commentcount]+1
	 WHERE videoid=@videoid
	
	--DECLARE @videouserid int,@title nvarchar(100), @description nvarchar(300),@classid int		
	--SELECT @videouserid=userid,@title=title,@classid=classid FROM class_video WHERE videoid=@videoid
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end
	--SET @description='在视频<a href="http://class.zgyey.com/'+CAST(@classid AS nvarchar(20))+'/classindex/videoview_v'+CAST(@videoid AS nvarchar(20))+'.html" target="_blank">:'+@title+'</a>发表评论'

	DECLARE @objectid int
	set @objectid=@@IDENTITY

	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --COMMIT TRANSACTION	
	   --EXEC class_actionlogs_ADD @userid,@author,@description ,'27',@objectid,@videouserid,0,@classid  
	   RETURN @objectid
	END






GO
