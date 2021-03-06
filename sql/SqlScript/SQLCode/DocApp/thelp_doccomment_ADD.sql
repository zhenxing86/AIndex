USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_doccomment_ADD]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加文档评论
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 22:57:51
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_doccomment_ADD]
@docid int,
@userid int,
@author nvarchar(30),
@body nvarchar(500),
@parentid int

 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	INSERT INTO thelp_doccomment(
	[docid],[userid],[author],[body],[commentdatetime],[parentid]
	)VALUES(
	@docid,@userid,@author,@body,getdate(),@parentid
	)

	--更新文档评论数(待增加)
	
		
	--DECLARE @name nvarchar(50),@LOGdescription nvarchar(300),@bloguserid int,@title nvarchar(30)
	--SELECT @name=t1.nickname ,@bloguserid=t1.userid,@title=t3.title FROM blog_user t1 INNER JOIN thelp_categories t2 ON t1.userid=t2.userid INNER JOIN thelp_documents t3 ON t2.categoryid=t3.categoryid  WHERE t3.docid=@docid	
	--SET @LOGdescription='在<a href="http://blog.zgyey.com/'+cast(@bloguserid as nvarchar(20))+'/index.html" target="_blank">'+@name+'</a>的文档 <a href="http://blog.zgyey.com/'+cast(@bloguserid as nvarchar(20))+'/thelp/thelpdocview_'+cast(@docid as nvarchar(20))+'.html" target="_blank"><<'+@title+'>></a> 上发表了评论'
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
		--EXEC sys_actionlogs_ADD @userid,@author,@LOGdescription ,'12',@objectid,@bloguserid,0
	   RETURN @objectid
	END












GO
