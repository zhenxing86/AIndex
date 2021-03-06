USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscomments_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：新增日记文章评论
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-02 13:56:50
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscomments_ADD]
@postsid int,
@fromuserid int,
@author nvarchar(50),
@content nvarchar(500),
@parentid int,
@private int


 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	--DECLARE @approve int
	--IF EXISTS(SELECT 1 FROM blog_posts_class WHERE postid=@postsid)
	--BEGIN
	--	DECLARE @kid int
	--	SELECT @kid=t1.kindergartenid FROM kmp..t_class t1 inner join blog_posts_class t2 on t1.id=t2.classid where t2.postid=@postsid
		
	--	IF EXISTS(SELECT * FROM permissionsetting WHERE kid=@kid and ptype=10)
	--	BEGIN
	--		SET @approve=0
	--	END
	--	ELSE
	--	BEGIN
	--		SET @approve=1
	--	END
	--END
	--ELSE
	--BEGIN
	--	SET @approve=1
	--END


	INSERT INTO blog_postscomments(
	[postsid],[fromuserid],[author],[commentdatetime],[content],[parentid],[approve],[private]
	)VALUES(
	@postsid,@fromuserid,@author,getdate(),@content,@parentid,1,@private
	)

	--更新贴子评论数
	UPDATE blog_posts SET commentcount=commentcount+1 WHERE postid=@postsid

--	DECLARE @description nvarchar(300),@title nvarchar(30),@name nvarchar(20),@userid int	
--	SELECT @title=title,@name=author,@userid=userid FROM blog_posts WHERE postid=@postsid 
--	--SET @description='<a href="http://blog.zgyey.com/'+cast(@fromuserid as nvarchar(20))+'/index.html" target="_blank">'+@author+'</a>   在<a href="http://blog.zgyey.com/'+cast(@userid as nvarchar(20))+'/index.html" target="_blank">'+@name+'</a>的日志 <a href="http://blog.zgyey.com/'+CAST(@userid AS nvarchar(20))+'/diary/diaryview_'+CAST(@postsid AS varchar(20))+'.html" target="_blank"><<'+@title+'>></a> 上发表了评论'
--if(len(@title)>5)
--	begin
--		set @title=substring(@title,1,5)+'...'
--	end	
--SET @description='在日记<a href="http://blog.zgyey.com/'+CAST(@userid AS nvarchar(20))+'/diary/diaryview_'+CAST(@postsid AS varchar(20))+'.html" target="_blank">:'+@title+'</a>发表评论'
	declare @objectid int
	set @objectid=@@IDENTITY
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		--exec sys_actionlogs_ADD @fromuserid,@author,@description ,'2',@objectid,@userid,0
	   RETURN @objectid
	END






GO
