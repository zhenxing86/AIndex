USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinoutline_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/11/15 10:31:59
------------------------------------
CREATE PROCEDURE [dbo].[kinoutline_Delete]
@kid int
 AS 
	DELETE [kinoutline]
	 WHERE kid=@kid 



GO
