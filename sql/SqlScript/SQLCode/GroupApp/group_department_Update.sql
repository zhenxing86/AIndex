USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_department_Update]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/2/24 9:37:30
------------------------------------
CREATE PROCEDURE [dbo].[group_department_Update]
@did int,
@dname varchar(50),
@superiorid int,
@gid int,
@deletetag int
 AS 
	UPDATE [group_department] SET 
	[dname] = @dname,[superiorid] = @superiorid,[gid] = @gid,[deletetag] = 1
	WHERE did=@did


GO
