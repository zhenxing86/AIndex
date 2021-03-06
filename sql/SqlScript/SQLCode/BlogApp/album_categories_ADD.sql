USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加相册分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_ADD]
@userid int,
@title nvarchar(50),
@description nvarchar(100),
@albumdispstatus int,
@isclassdisplay int,
@classid int,
@viewpermission nvarchar(20)

 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @displayorder int
	DECLARE @orderno int
	SELECT @displayorder=max(displayorder),@orderno=max(orderno) FROM album_categories WHERE userid=@userid	

	IF(@orderno is null)
	BEGIN
		SET @orderno=1
	END
	ELSE
	BEGIN
		SET @orderno=@orderno+1
	END
	
	--新增相册
	INSERT INTO album_categories(
	[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime],[isclassdisplay],[classid],[orderno],[viewpermission],[deletetag]
	)VALUES(
	@userid,@title,@description,@displayorder,@albumdispstatus,0,getdate(),@isclassdisplay,@classid,@orderno,@viewpermission,1
	)	
	declare @objectid int
	set @objectid=@@IDENTITY
	--更新博客相册数量
	UPDATE blog_baseconfig SET albumcount=albumcount+1 WHERE userid=@userid
		

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
