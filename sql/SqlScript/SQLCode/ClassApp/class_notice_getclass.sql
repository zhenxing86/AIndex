USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_getclass]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：修改公告 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 9:44:05
------------------------------------
create PROCEDURE [dbo].[class_notice_getclass]
@noticeid int
 AS 
	select classid from class_notice_class where noticeid=@noticeid






GO
