USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManageattachs_Delete]    Script Date: 2014/11/24 23:05:18 ******/
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
CREATE PROCEDURE [dbo].[SchoolBus_SafeManageattachs_Delete]
@filename varchar(200)
 AS 
	DELETE [SchoolBus_SafeManageattachs]
	 WHERE @filename=[filename]










GO
