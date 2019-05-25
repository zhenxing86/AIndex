USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_GetCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询广告列表数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_GetCount]
@position int
AS 
	DECLARE @count INT
	SELECT @count=count(1) FROM [advertise] WHERE position=@position and status=1 
	RETURN @count
GO
