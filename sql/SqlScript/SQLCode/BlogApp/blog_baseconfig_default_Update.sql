USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_baseconfig_default_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：修改个人博客中的默认设置
--项目名称：blog
--说明：
--时间：2009-5-27 17:10:57
------------------------------------
CREATE PROCEDURE [dbo].[blog_baseconfig_default_Update]
@userid int,
@posttoclassdefault int,
@commentpermission int,
@openblogquestion nvarchar(30),
@openbloganswer nvarchar(30),
@kininfo int,
@messagepermission int,
@postviewpermission int,
@albumviewpermission int

 AS 
	UPDATE blog_baseconfig SET 
	[posttoclassdefault] = @posttoclassdefault,[commentpermission] = @commentpermission,[openblogquestion] = @openblogquestion,[openbloganswer]=@openbloganswer,[kininfohide]=@kininfo,messagepermission=@messagepermission,postviewpermission=@postviewpermission,albumviewpermission=@albumviewpermission
	WHERE userid=@userid 

	IF @@ERROR <> 0 
	BEGIN			
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END





GO
