USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[mapsmodel_Update]
 @kid int,
 @kname varchar(50),
 @mappoint varchar(50),
 @mapdesc varchar(50),
 @isgood int
 
 AS 
	UPDATE kininfoapp..kindergarten_condition SET 
  [kname] = @kname,
 [mappoint] = @mappoint,
 [mapdesc] = @mapdesc,
 [isgood] = @isgood
 	 WHERE kid=@kid 










GO
