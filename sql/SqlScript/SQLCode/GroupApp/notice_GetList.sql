USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[notice_GetList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询通知 列表
--项目名称：ServicePlatform
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[notice_GetList]
 AS 
		SELECT top(5)
		noticeid,title,author,titlecolor,content,createdatetime,viewcount,orderno,status
		 FROM [notice] WHERE status=1 ORDER BY orderno DESC,createdatetime DESC

GO
