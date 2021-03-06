USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboxattach_ADD]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加消息附件
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-11-25 15:21:32
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboxattach_ADD]
@messageboxid int,
@title nvarchar(50),
@filename nvarchar(200),
@filepath nvarchar(500)

 AS 
	INSERT INTO blog_messageboxattach(
	[messageboxid],[title],[filename],[filepath],[createdatetime]
	)VALUES(
	@messageboxid,@title,@filename,@filepath,getdate()
	)

	IF(@@ERROR<>0)
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN @@IDENTITY
	END







GO
