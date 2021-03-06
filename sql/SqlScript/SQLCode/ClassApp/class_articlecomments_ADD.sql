USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlecomments_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加班级文章评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articlecomments_ADD]
@articleid int,
@userid int,
@author nvarchar(20),
@content nvarchar(500),
@parentid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	INSERT INTO [class_articlecomments](
	[articleid],[userid],[author],[content],[commentdatetime],[parentid],[status]
	)VALUES(
	@articleid,@userid,@author,@content,getdate(),@parentid,1
	)	

	DECLARE @objectid int
	set @objectid=@@IDENTITY

	--更新评论数量	
	UPDATE class_article SET [commentcount]=[commentcount]+1
	 WHERE articleid=@articleid
	
--	DECLARE @articleuserid int,@title nvarchar(100), @description nvarchar(300),@classid int		
--	SELECT @articleuserid=userid,@title=title,@classid=classid FROM class_article WHERE articleid=@articleid
--	if(len(@title)>5)
--	begin
--		set @title=substring(@title,1,5)+'...'
--	end
--	SET @description='在文章:'+@title+'发表评论'


	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   COMMIT TRANSACTION	
--	   EXEC class_actionlogs_ADD @userid,@author,@description ,'29',@objectid,@articleuserid,0,@classid  
	   RETURN @objectid
	END




GO
