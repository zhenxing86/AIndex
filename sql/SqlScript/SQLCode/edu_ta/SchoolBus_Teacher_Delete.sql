USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Teacher_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:47:00
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Teacher_Delete]
@ID int
 AS 
	update [SchoolBus_Teacher] set deletetag=0
	 WHERE ID=@ID 









GO
