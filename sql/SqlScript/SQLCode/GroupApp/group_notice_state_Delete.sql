USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_state_Delete]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





	
------------------------------------
--用途：删除一条记录 
--项目名称：group_notice_state
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_state_Delete]
  @id int             	
 AS 
	DELETE [group_notice_state]
	 WHERE   [id] = @id             	






GO
