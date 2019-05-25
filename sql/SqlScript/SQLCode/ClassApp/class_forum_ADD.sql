USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加班级论坛留言 
--项目名称：classhomepage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_ADD]
@title nvarchar(50),
@contents ntext,
@userid int,
@author nvarchar(30),
@kid int,
@classid int,
@istop int,
@parentid int,
@isblogpost int,
@approve int

 AS 
--IF(@isblogpost=1)
--BEGIN
--	DECLARE @fromuserid int
--	DECLARE @name nvarchar(50)
--	SELECT @fromuserid=t1.bloguserid,@name=t2.nickname FROM bloguserkmpuser t1 inner join blog_user t2 on t1.bloguserid=t2.userid WHERE kmpuserid=@userid
--	IF(@fromuserid is null)
--	BEGIN
--		SET @fromuserid=0
--		SELECT @name=nickname  FROM kmp..t_users where id=@userid
--	END
--	EXEC blog_postscomments_ADD @parentid,@fromuserid,@name,@contents,0,0
--END
--ELSE
--BEGIN
	INSERT INTO class_forum(
	[title],[contents],[userid],[author],[kid],[classid],[createdatetime],[istop],[parentid],[approve],[status]
	)VALUES(
	@title,@contents,@userid,@author,@kid,@classid,getdate(),@istop,@parentid,@approve,1
	)
	declare @objectid int
	set @objectid=@@IDENTITY

if(@parentid>0)
begin

	update class_forum set lastreplaytime=getdate(),replaycount=replaycount+1 where classforumid=@parentid

end
	--DECLARE @description nvarchar(300)
	--if(len(@title)>5)
	--begin
	--	set @title=substring(@title,1,5)+'...'
	--end	
	--IF(@parentid=0)
	--BEGIN
	--	SET @description='发表了帖子:<a href="http://class.zgyey.com/'+cast(@classid as nvarchar(20))+'/classindex/forumview_f'+cast(@@IDENTITY as nvarchar(20))+'_p1i1b0.html" target="_blank">:'+@title+'</a>'
	--END
	--ELSE
	--BEGIN
	--	DECLARE @oldtitle nvarchar(50)
	--	SELECT @oldtitle=title FROM class_forum WHERE classforumid=@parentid
	--	SET @description='回复了帖子:<a href="http://class.zgyey.com/'+cast(@classid as nvarchar(20))+'/classindex/forumview_f'+cast(@parentid as nvarchar(20))+'_p1i1b0.html" target="_blank">:'+@oldtitle+'</a>'
	--END
	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN		
		--exec class_actionlogs_ADD @userid,@author,@description ,'22',@objectid,@userid,0,@classid
	   RETURN @objectid
	END
--END








GO
