USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_comments_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：增加相片评论
--项目名称：zgyeyblog 
--说明：
--时间：2008-09-29 07:54:31
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_comments_ADD]
@photoid int,
@userid int,
@author nvarchar(100),
@content ntext,
@parentid int

 AS 
	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION

	--新增照片评论
	INSERT INTO album_comments(
	[photoid],[userid],[author],[content],[commentdatetime],[parentid]
	)VALUES(
	@photoid,@userid,@author,@content,getdate(),@parentid
	)

	--更新照片评论数量	
	UPDATE album_photos SET [commentcount]=[commentcount]+1
	 WHERE photoid=@photoid

	declare @objectid int
	set @objectid=@@IDENTITY
	IF @@ERROR <> 0 
	BEGIN 
	--	ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	  -- COMMIT TRANSACTION
	RETURN @objectid
	END







GO
