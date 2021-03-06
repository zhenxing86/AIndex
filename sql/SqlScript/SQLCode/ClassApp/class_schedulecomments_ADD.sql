USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedulecomments_ADD]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加教学安排评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 22:57:00
------------------------------------
CREATE PROCEDURE [dbo].[class_schedulecomments_ADD]
@scheduleid int,
@userid int,
@author nvarchar(50),
@content ntext,
@parentid int,
@kid int

 AS 
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	INSERT INTO [class_schedulecomments](
	[scheduleid],[userid],[author],[content],[commentdatetime],[parentid]
	)VALUES(
	@scheduleid,@userid,@author,@content,getdate(),@parentid
	)	

	--更新评论数量	
--	UPDATE class_schedule SET [commentcount]=[commentcount]+1
--	 WHERE scheduleid=@scheduleid
	--DECLARE @scheduleuserid int,@title nvarchar(100), @description nvarchar(300),@classid int		
	--SELECT @scheduleuserid=userid,@title=title,@classid=classid FROM thelp_documents WHERE docid=@scheduleid
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end
	--SET @description='在教学安排<a href="http://class.zgyey.com/'+CAST(@classid AS nvarchar(20))+'/classindex/scheduleview_s'+CAST(@scheduleid AS nvarchar(20))+'.html" target="_blank">:'+@title+'</a>发表评论'

	DECLARE @objectid int
	set @objectid=SCOPE_IDENTITY()  

	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --COMMIT TRANSACTION	
	   --EXEC class_actionlogs_ADD @userid,@author,@description ,'25',@objectid,@scheduleuserid,0,@classid  
	   RETURN @objectid
	END






GO
