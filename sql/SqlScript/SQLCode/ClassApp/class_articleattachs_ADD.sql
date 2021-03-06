USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articleattachs_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加班级文章附件
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articleattachs_ADD]
@articleid int,
@title nvarchar(50),
@filename nvarchar(200),
@filepath nvarchar(500)


 AS 
	INSERT INTO [class_articleattachs](
	[articleid],[title],[filename],[filepath],[createdatetime],[status]
	)VALUES(
	@articleid,@title,@filename,@filepath,getdate(),1
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
