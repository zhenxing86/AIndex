USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_Update]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：修改文档
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_Update]
@docid int,
@title nvarchar(100),
@description nvarchar(200),
@body ntext,
@classid int
 AS 
	
       UPDATE class_schedule SET 
	   [title] = @title,content = @body,[classid]=@classid
		WHERE scheduleid=@docid 

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		COMMIT TRANSACTION
	   RETURN (1)
	END







GO
