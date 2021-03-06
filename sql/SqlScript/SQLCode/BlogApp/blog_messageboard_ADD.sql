USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboard_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：增加留言 
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 13:57:24
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboard_ADD]
@userid int,
@fromuserid int,
@author nvarchar(50),
@content ntext,
@msgstatus int,
@parentid int

 AS 
	INSERT INTO blog_messageboard(
	[userid],[fromuserid],[author],[content],[msgstatus],[msgdatetime],[parentid]
	)VALUES(
	@userid,@fromuserid,@author,@content,@msgstatus,getdate(),@parentid
	)		
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END
	



GO
