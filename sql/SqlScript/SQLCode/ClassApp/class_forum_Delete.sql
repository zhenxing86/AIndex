USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除班级论坛留言 
--项目名称：classhomepage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_Delete]
@classforumid int,
@blogpost int
 AS 


--	DECLARE  @temp table
--	(
--	  id int identity(1,1),
--	  classforumid int
--	)
--	
--	declare @logforumid INT
--	declare @n INT
--	declare @rows INT
--	select @n=1
--	INSERT INTO @temp(classforumid) SELECT classforumid FROM class_forum where parentid=@classforumid
--	select @rows = @@rowcount
--	while @n <= @rows
--	BEGIN
--
--		SELECT @logforumid=classforumid FROM @temp WHERE id = @n ORDER BY classforumid desc
--		EXEC [class_actionlogs_Delete] @logforumid,22		
--		SELECT @n = @n + 1
--	END
--
	--IF(@blogpost=1)
	--BEGIN
	--	DELETE blog_posts_class WHERE postid=@classforumid
	--END
	--ELSE
	IF(@classforumid<>0)
	BEGIN
--		DELETE class_forum
--		 WHERE classforumid=@classforumid or parentid=@classforumid
		--EXEC [class_actionlogs_Delete] @classforumid,22	
		UPDATE class_forum SET status=-1 WHERE classforumid=@classforumid or parentid=@classforumid
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
