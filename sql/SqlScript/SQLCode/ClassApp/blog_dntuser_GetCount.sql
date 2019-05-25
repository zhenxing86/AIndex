USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_dntuser_GetCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取班级主页论坛用户数
--项目名称：zgyeyblog
--说明：
--时间：2010-02-08 15:25:19
------------------------------------
create PROCEDURE [dbo].[blog_dntuser_GetCount]
@kmpuserid int
 AS 
	declare @usercount int
	select @usercount=count(*) from blog_dntuser
	where kmpuserid=@kmpuserid
	RETURN @usercount





GO
