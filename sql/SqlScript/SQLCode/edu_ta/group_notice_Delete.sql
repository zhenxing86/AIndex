USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_Delete]
@nid int
 AS 
	DELETE [group_notice]
	 WHERE nid=@nid 








GO
