USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_noticeattachs_Delete]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/2/6 14:22:20
------------------------------------
CREATE PROCEDURE [dbo].[group_noticeattachs_Delete]
@attachsid int
 AS 
	DELETE [group_noticeattachs]
	 WHERE attachsid=@attachsid 



GO
