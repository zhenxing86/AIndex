USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_actionlogs_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取最新动态
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
------------------------------------
CREATE PROCEDURE [dbo].[blog_actionlogs_GetList]	
 AS 
	select * from AppLogs.dbo.blog_tmp_actionlogs order by actiondatetime desc




GO
