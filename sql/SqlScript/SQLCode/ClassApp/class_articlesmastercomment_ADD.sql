USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlesmastercomment_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------
--用途：增加班级文章园长点评 
--项目名称：zgyeyblog
--说明：
--时间：2009-5-14 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articlesmastercomment_ADD]
@articleid int,
@content nvarchar(500),
@userid int,
@author nvarchar(30),
@parentid int

 AS 
	INSERT INTO class_articlesmastercomment(
	[articleid],[content],[userid],[author],[commentdatetime],[parentid],[status]
	)VALUES(
	@articleid,@content,@userid,@author,getdate(),@parentid,1
	)

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END



GO
