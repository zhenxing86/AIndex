USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photocomments_ADD]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加相片评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:01:54
------------------------------------
CREATE PROCEDURE [dbo].[class_photocomments_ADD]
@photoid int,
@userid int,
@author nvarchar(100),
@content ntext,
@parentid int

 AS 

	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	INSERT INTO class_photocomments(
	[photoid],[userid],[author],[content],[commentdatetime],[parentid],[status]
	)VALUES(
	@photoid,@userid,@author,@content,getdate(),@parentid,1
	)

	--更新照片评论数量	
	UPDATE class_photos SET [commentcount]=[commentcount]+1
	 WHERE photoid=@photoid

	--DECLARE @title nvarchar(100), @description nvarchar(300),@classid int,@photouserid int,@albumid int,@orderno int
	--SELECT @title=t1.title,@classid=t2.classid,@photouserid=t2.userid,@albumid=t1.albumid,@orderno=t1.orderno FROM class_photos t1 INNER JOIN class_album t2 ON t1.albumid=t2.albumid WHERE t1.photoid=@photoid
 --   if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end
	--SET @description='在照片<a href="http://class.zgyey.com/'+CAST(@classid AS nvarchar(20))+'/classindex/albumphotoview_a'+CAST(@albumid AS nvarchar(20))+'_p'+CAST(@orderno AS nvarchar(20))+'.html" target="_blank">:'+@title+'</a>发表评论'
	declare @objectid int
	set @objectid=@@IDENTITY
	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --COMMIT TRANSACTION
	   --EXEC class_actionlogs_ADD @userid,@author,@description ,'24',@objectid,@photouserid,0,@classid
	RETURN @objectid
	END







GO
