USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[Authority_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：删除一条记录 
--项目名称：Authority
------------------------------------
CREATE PROCEDURE [dbo].[Authority_Delete]
  @gid int                	
 AS 
	DELETE [Authority]
	 WHERE   [gid] = @gid                	






GO
