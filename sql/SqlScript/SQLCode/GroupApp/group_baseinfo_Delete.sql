USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_baseinfo_Delete]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/6 10:39:26
------------------------------------
CREATE PROCEDURE [dbo].[group_baseinfo_Delete]
@gid int
 AS 
	DELETE [group_baseinfo]
	 WHERE gid=@gid 



GO
