USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_mastercomment_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取园长点评列表 
--项目名称：zgyeyblog
--说明：
--时间：2009-2-3 10:20:28
------------------------------------
CREATE PROCEDURE [dbo].[thelp_mastercomment_GetList]
@docid int
 AS 
	SELECT 
	mastercommentid,docid,content,userid,author,commentdatetime,parentid
	 FROM thelp_mastercomment WHERE docid=@docid






GO
