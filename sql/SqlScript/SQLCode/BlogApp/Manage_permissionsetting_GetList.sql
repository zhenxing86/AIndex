USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_permissionsetting_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：取配置权限
--项目名称：zgyeyblog
--说明：
--时间：2009-12-11 18:00:19
------------------------------------
create PROCEDURE [dbo].[Manage_permissionsetting_GetList]
@kid int
 AS 
SELECT pid,ptype,kid
FROM permissionsetting WHERE kid=@kid



GO
