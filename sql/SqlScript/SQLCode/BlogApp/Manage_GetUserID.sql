USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetUserID]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取符合条件的用户ID
--项目名称：zgyeyblog
--说明：
--时间：2008-12-28 21:48:51
------------------------------------
CREATE PROCEDURE [dbo].[Manage_GetUserID]    
    @strWhere     varchar(1000) = ''  -- 查询条件 (注意: 不要加 where)
AS

SET @strWhere = CommonFun.dbo.FilterSQLInjection(@strWhere)

	DECLARE @strSQL   varchar(6000)       -- 主语句
	SET @strSQL='SELECT userid FROM v_userinfo WHERE '+@strWhere
	EXEC (@strSQL)

GO
