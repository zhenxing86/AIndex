USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_categories_ADD]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：新增文档分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 22:36:39
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_categories_ADD]
@parentid int,
@userid int,
@title nvarchar(50),
@description nvarchar(100)

 AS 
	DECLARE @displayorder int
	SELECT @displayorder=max(displayorder)+1 FROM thelp_categories WHERE userid=@userid	
	
	INSERT INTO thelp_categories(
	[parentid],[userid],[title],[description],[displayorder],[status],[documentcount],[createdatetime]
	)VALUES(
	@parentid,@userid,@title,@description,@displayorder,1,0,getdate()
	)
	

	--DECLARE @name nvarchar(50),@LOGdescription nvarchar(300)
	--SELECT @name=nickname FROM blog_user WHERE userid=@userid
	--SET @LOGdescription='<a href="http://blog.zgyey.com/'+CAST(@userid AS nvarchar(20))+'/index.html" target="_blank">'+@name+'</a>  添加了文档分类 " '+@title+' "'
	--SET @LOGdescription='添加了文档分类 "'+@title+'"'

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   --EXEC sys_actionlogs_ADD @userid,@name,@LOGdescription ,'10',0,0,0
	   RETURN @@IDENTITY
	END





GO
