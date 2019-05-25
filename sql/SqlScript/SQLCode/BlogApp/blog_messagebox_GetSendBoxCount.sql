USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetSendBoxCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到发件箱短信数 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-14 17:30:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetSendBoxCount]
@userid int
 AS 

	DECLARE @messageboxcount int
	SELECT @messageboxcount=count(1) FROM blog_messagebox WHERE fromuserid=@userid 
	RETURN @messageboxcount






GO
