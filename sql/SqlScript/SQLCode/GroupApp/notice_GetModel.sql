USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[notice_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询通知信息
--项目名称：ServicePlatform
--说明：
--时间：2010-2-25 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[notice_GetModel]
@noticeid int
 AS 
		SELECT noticeid,title,author,titlecolor,content,createdatetime,viewcount,orderno,status
		 FROM [notice] WHERE noticeid=@noticeid

GO
