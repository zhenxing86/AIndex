USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetAreaInfo]    Script Date: 08/28/2013 14:42:21 ******/
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

	declare @strSQL   varchar(6000)       -- 主语句
	set @strSQL = 'select *  from [kmp]..[T_Area] where ' + @strWhere +' ORDER BY ID'
	exec (@strSQL)
GO
