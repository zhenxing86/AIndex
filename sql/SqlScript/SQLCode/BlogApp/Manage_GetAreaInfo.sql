USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetAreaInfo]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取省市地区信息  
--说明：
------------------------------------
CREATE PROCEDURE [dbo].[Manage_GetAreaInfo]   
@strWhere     varchar(1000) = ''  -- 查询条件 (注意: 不要加 where)
AS

SET @strWhere = CommonFun.dbo.FilterSQLInjection(@strWhere)
	declare @strSQL   varchar(6000)       -- 主语句
	set @strSQL = 'select *  from basicdata.dbo.area where ' + @strWhere +' ORDER BY ID'
	exec (@strSQL)

GO
