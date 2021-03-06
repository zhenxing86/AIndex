USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscategories_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：增加日记分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-30 22:57:13
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscategories_ADD]
@userid int,
@title nvarchar(30),
@description nvarchar(100)
 AS 

	DECLARE @displayorder int
	SELECT @displayorder=max(displayorder) FROM blog_postscategories WHERE userid=@userid	
	
	INSERT INTO blog_postscategories(
	[userid],[title],[description],[displayorder],[postcount],[createdatetime]
	)VALUES(
	@userid,@title,@description,@displayorder,0,getdate()
	)
	
	--DECLARE @name nvarchar(50),@LOGdescription nvarchar(300)
	--SELECT @name=nickname FROM blog_user WHERE userid=@userid	
	--SET @LOGdescription='添加了日记分类"'+@title+'"'

	declare @objectid int
	set @objectid=@@IDENTITY
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	--EXEC sys_actionlogs_ADD @userid,@name,@LOGdescription ,'9',@objectid,@userid,0
	   RETURN @objectid
	END





GO
