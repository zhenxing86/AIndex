USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManageAttachs_DeleteByAId]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/29 17:05:42
------------------------------------
create PROCEDURE [dbo].[SchoolBus_SafeManageAttachs_DeleteByAId]
@attachsid int
 AS 
	DELETE [SchoolBus_SafeManageattachs]
	 WHERE attachsid=@attachsid








GO
