USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManage_Delete]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:45:11
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_SafeManage_Delete]
@ID int
 AS 
	DELETE [SchoolBus_SafeManage]
	 WHERE ID=@ID 



GO
