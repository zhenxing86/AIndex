USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_Delete]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条记录 
--项目名称：
--说明：
--时间：2012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[mapsmodel_Delete]
@id int
 AS 
	DELETE [mapsmodel]
	 WHERE kid=@id 



GO
