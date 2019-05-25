USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_notice_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询通知数 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[Manage_notice_GetCount]
@status int
 AS 
	DECLARE @count int
	SELECT	@count=count(1)	 FROM [notice] WHERE status=@status
	RETURN @count

GO
