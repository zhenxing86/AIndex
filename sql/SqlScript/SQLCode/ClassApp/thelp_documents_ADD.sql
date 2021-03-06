USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_ADD]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：新增文档
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_ADD]
@title nvarchar(100),
@body ntext,
@userid int,
@docauthor nvarchar(30),
@classid int,
@kid int

 AS 
	
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	INSERT INTO class_schedule(
	[title],[content],[createdatetime],[viewcount],[userid],[author],[classid],[kid]
	)VALUES(
	@title,@body,getdate(),0,@userid,@docauthor,@classid,@kid
	)

	IF @@ERROR <> 0 
	BEGIN 
	--	ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
		 --EXEC sys_actionlogs_ADD @userid,@name,@LOGdescription ,'11',@docid,@userid1,0
	   RETURN Scope_Identity()
	END

GO
