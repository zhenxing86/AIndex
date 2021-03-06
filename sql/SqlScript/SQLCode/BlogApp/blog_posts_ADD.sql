USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：发表日记文章
--项目名称：zgyeyblog
--说明：
--时间：-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_ADD]
@author nvarchar(20),
@userid int,
@title nvarchar(30),
@content ntext,
@poststatus int,
@categoriesid int,
@commentstatus int,
@IsTop bit,
@IsSoul bit,
@smile nvarchar(30),
@viewpermission int

 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	INSERT INTO blog_posts(
	[author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],[commentstatus],[IsTop],[IsSoul],[postupdatetime],

[commentcount],[viewcounts],[smile],[IsHot],[viewpermission],[deletetag]
	)VALUES(
	@author,@userid,getdate(),@title,@content,@poststatus,@categoriesid,@commentstatus,@IsTop,@IsSoul,getdate(),0,0,@smile,0,@viewpermission,1
	)
	declare @objectid int
	set @objectid=@@IDENTITY
	
	--更新日志分类表日志数量	
	UPDATE blog_postscategories SET postcount=postcount+1 
	WHERE categoresid=@categoriesid

	--更新博客配置表日志总数量
	UPDATE blog_baseconfig SET postscount=postscount+1, updatedatetime=getdate(),lastposttitle=@title,
	lastpostid=@@IDENTITY
	WHERE userid=@userid
	
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION		
	   RETURN @objectid
	END






GO
